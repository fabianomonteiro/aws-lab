variable "lambda_function_name" {
  default = "aws-lab-lambda"
}

variable "bucket_name" {
  default = "aws-lab-bucket-01"
}

variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnets" {
  description = "The subnets where the ECS service will run"
  type        = list(string)
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
  default     = 1
}
