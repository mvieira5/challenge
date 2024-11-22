provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source  = "../../../terraform-modules/vpc"

  name           = "challenge-vpc"
  vpc_cidr       = "10.0.0.0/16"
  public_subnets = {
    "us-east-1a" = "10.0.1.0/24",
    "us-east-1b" = "10.0.2.0/24"
  }
  private_subnets = {
    "us-east-1a" = "10.0.3.0/24",
    "us-east-1b" = "10.0.4.0/24"
  }
  region = "us-east-1"
}

module "alb" {
  source                  = "../../../terraform-modules/alb"

  region                  = "us-east-1"
  name                    = "challenge-alb"
  vpc_id                  = module.vpc.vpc_id
  subnets                 = module.vpc.public_subnets
  target_group_port       = 80
  target_group_protocol   = "HTTP"
  health_check_path       = "/"
  enable_deletion_protection = false
}

module "ecs_fargate" {
  source            = "../../../terraform-modules/ecs"

  region            = "us-east-1"
  cluster_name      = "challenge-cluster"
  cpu               = "256"
  memory            = "512"
  desired_count     = 2
  subnets           = module.vpc.private_subnets
  security_group_id = module.alb.alb_sg.id
  assign_public_ip  = false

  container_definitions = jsonencode([
    {
      name      = "challenge-app"
      image     = "<account_id>.dkr.ecr.us-east-1.amazonaws.com/challenge-cluster:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])

  load_balancer {
    target_group_arn = module.alb.ecs_tg.arn
    container_name   = "challenge-app"
    container_port   = 80
  }
}
