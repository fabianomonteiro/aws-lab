variable "name" {
  description = "Name prefix for ALB and related resources"
  type        = string
}

variable "internal" {
  description = "Whether the ALB is internal"
  type        = bool
  default     = false
}

variable "subnets" {
  description = "Subnets to attach the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for the ALB"
  type        = string
}

variable "target_port" {
  description = "Port to forward traffic to on the target group"
  type        = number
  default     = 8080
}

variable "allowed_ingress_cidrs" {
  description = "List of CIDR blocks allowed to access the ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Permitir acesso público por padrão
}