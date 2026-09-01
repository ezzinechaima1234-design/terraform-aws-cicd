output "alb_dns_name" {
  description = "Nom DNS public de l'ALB (URL pour accéder à l'app)"
  value       = aws_lb.app.dns_name
}

output "ec2_instance_id" {
  description = "ID de l'instance EC2 créée"
  value       = aws_instance.app.id
}

output "ec2_private_ip" {
  description = "IP privée de l'instance EC2"
  value       = aws_instance.app.private_ip
}