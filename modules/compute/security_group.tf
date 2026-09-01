# Security Group pour l'ALB (reçoit le trafic depuis Internet)
resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg"
  description = "Autorise le trafic HTTP entrant depuis Internet"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP depuis Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Tout le trafic sortant autorisé"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

# Security Group pour l'EC2 (reçoit uniquement le trafic depuis l'ALB)
resource "aws_security_group" "ec2" {
  name        = "${var.project_name}-ec2-sg"
  description = "Autorise le trafic HTTP uniquement depuis l'ALB"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP depuis l'ALB uniquement"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Tout le trafic sortant autorisé"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-ec2-sg"
  }
}