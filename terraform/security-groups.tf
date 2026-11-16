resource "aws_security_group" "task" {
  name        = "${var.project_name}-sg"
  description = "Allow inbound Flask traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Flask application"
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-sg"
    Project = var.project_name
  }
}