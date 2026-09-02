variable "project_name" {
  description = "Nom du projet, utilisé pour taguer les ressources"
  type        = string
}

variable "vpc_id" {
  description = "ID du VPC dans lequel déployer les ressources"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs des subnets publics (pour EC2 et ALB)"
  type        = list(string)
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "ID de l'AMI à utiliser pour l'instance EC2"
  type        = string
}