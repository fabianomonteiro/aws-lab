module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}

module "apigateway" {
  source   = "./modules/apigateway"
  api_name = "aws-lab-api"
}

module "lambda" {
  source               = "./modules/lambda"
  lambda_function_name = var.lambda_function_name
  lambda_zip_path      = "../app/lambda/lambda.zip"
  bucket_name          = module.s3.bucket_name
  api_id               = module.apigateway.api_id
  api_arn              = "arn:aws:execute-api:${var.aws_region}:${var.aws_account_id}:${module.apigateway.api_id}"
  route_key            = "lambda-route"
}

#module "ecr" {
# source = "./modules/ecr"
#}

module "alb" {
  source          = "./modules/alb"
  name            = "kotlin-app"
  internal        = false
  subnets         = var.subnets
  vpc_id          = var.vpc_id
  target_port     = 8080
  allowed_ingress_cidrs = ["0.0.0.0/0"] # Atualize conforme necessário
}

module "ecs" {
  source           = "./modules/ecs"
  cluster_name     = "kotlin-ecs-cluster"
  vpc_id           = var.vpc_id
  subnets          = var.subnets
  container_image  = "785349498866.dkr.ecr.us-east-1.amazonaws.com/kotlin-app:latest" # Substitua pelo URL correto
  desired_count    = var.desired_count
  api_id           = module.apigateway.api_id # Adicione o API ID como variável
  target_group_arn = module.alb.target_group_arn
  alb_dns_name     = module.alb.alb_dns_name # Passar o DNS do ALB
  depends_on = [ module.alb ]
}