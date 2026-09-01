variable "project_name" {
  description = "Nom du projet, utilisé pour taguer les ressources"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloc CIDR du VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Liste des blocs CIDR pour les subnets publics"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  description = "Liste des zones de disponibilité"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}