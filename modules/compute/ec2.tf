resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.ec2.id]

  # Script exécuté au premier démarrage : installe un petit serveur web de test
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello depuis Terraform - ${var.project_name}</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.project_name}-ec2"
  }
}