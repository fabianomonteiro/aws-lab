variable "lambda_function_name" {
  description = "Nome da função Lambda"
  type        = string
}

variable "lambda_zip_path" {
  description = "Caminho do arquivo ZIP da Lambda"
  type        = string
}

variable "bucket_name" {
  description = "Nome do bucket S3 usado pela Lambda"
  type        = string
}

variable "api_id" {
  description = "The ID of the API Gateway"
  type        = string
}

variable "api_arn" {
  description = "The ARN of the API Gateway"
  type        = string
}

variable "route_key" {
  description = "The route key for the Lambda"
  type        = string
}