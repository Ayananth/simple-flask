variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project resource naming prefix"
  type        = string
  default     = "task-3-49"
}

variable "dockerhub_username" {
  description = "Docker Hub username"
  type        = string
}

variable "docker_image" {
  description = "Docker Hub image"
  type        = string
  default     = "task-3-49-app"
}

variable "container_port" {
  description = "Flask application port"
  type        = number
  default     = 5000
}

variable "desired_count" {
  description = "Number of ECS tasks"
  type        = number
  default     = 1
}