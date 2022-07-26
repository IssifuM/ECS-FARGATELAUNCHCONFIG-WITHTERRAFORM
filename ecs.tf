#define ecs launch type

/* resource "aws_ecs_cluster" "ecs_cluster" {
  name = "project-ecs-cluster"
}
resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_providers" {
  cluster_name       = aws_ecs_cluster.ecs_cluster.name
  capacity_providers = ["FARGATE SPOT", "FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE SPOT"


    module "ecs_fargate" {
      source = "umotif-public/ecs-fargate/aws"



      version                         = "~> 6.1.0"
      name_prefix                     = "ecs-fargate-week20"
      vpc_id                          = aws_vpc.Prod_rock_VPC.id
      private_subnet_ids              = [aws_subnet.Test-priv-sub1.id, aws_subnet.Test-priv-sub2.id]
      cluster_id                      = aws_ecs_cluster.ecs_cluster.id
      task_container_image            = var.app_image
      task_definition_cpu             = 256
      task_definition_memory          = 512
      task_container_port             = 80
      task_container_assign_public_ip = true
      load_balanced                   = false
      target_groups = [
        { target_group_name = "tg-fargate-project"
          container_port    = 80
        }
      ]
      health_check = {
        port = "traffic-port"
        path = "/"
      }
      tags = {
        Environment = "Dev"
        Project     = "Week20"
      }
    }
  }
} */


resource "aws_ecs_cluster" "cluster" {
  name = "example-ecs-cluster"

  capacity_providers = ["FARGATE_SPOT", "FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

module "ecs-fargate" {
  source  = "umotif-public/ecs-fargate/aws"
  version = "~> 6.1.0"

  name_prefix        = "ecs-fargate-example"
  vpc_id             = aws_vpc.Prod_rock_VPC.id
  private_subnet_ids = [aws_subnet.Test-priv-sub1.id, aws_subnet.Test-priv-sub2.id]

  cluster_id = aws_ecs_cluster.cluster.id

  task_container_image   = "centos"
  task_definition_cpu    = 256
  task_definition_memory = 512

  task_container_port             = 80
  task_container_assign_public_ip = true

  load_balanced = false

  target_groups = [
    {
      target_group_name = "tg-fargate-example"
      container_port    = 80
    }
  ]

  health_check = {
    port = "traffic-port"
    path = "/"
  }

  tags = {
    Environment = "test"
    Project     = "Test"
  }
}










