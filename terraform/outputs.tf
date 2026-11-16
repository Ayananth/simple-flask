output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_service_name" {
  value = module.ecs.services["app"].name
}

output "ecs_service_arn" {
  description = "ARN of the ECS service"
  value       = module.ecs.services["app"].id
}

output "security_group_id" {
  value = aws_security_group.task.id
}