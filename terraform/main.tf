
# Get an available Availability Zone
data "aws_availability_zones" "available" {
  state = "available"
}

# VPC module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = "${var.project_name}-vpc"
  cidr = "10.0.0.0/16"

  azs            = [data.aws_availability_zones.available.names[0]]
  public_subnets = ["10.0.1.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  map_public_ip_on_launch = true

  tags = {
    Project = var.project_name
  }
}

# ECS module
module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "5.12.0"

  cluster_name = "${var.project_name}-cluster"

  services = {
    app = {
      name          = "${var.project_name}-service"
      cpu           = 256
      memory        = 512
      desired_count = var.desired_count
      launch_type   = "FARGATE"

      enable_autoscaling = false

      subnet_ids         = module.vpc.public_subnets
      security_group_ids = [aws_security_group.task.id]
      assign_public_ip   = true

      create_security_group = false

      container_definitions = {
        app = {
          image     = "${var.dockerhub_username}/${var.docker_image}:latest"
          essential = true

          port_mappings = [
            {
              name          = "flask"
              containerPort = var.container_port
              protocol      = "tcp"
            }
          ]
        }
      }
    }
  }

  tags = {
    Project = var.project_name
  }
}
