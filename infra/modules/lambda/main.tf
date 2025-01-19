resource "aws_lambda_function" "lambda" {
  function_name = var.lambda_function_name
  runtime       = "python3.9"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_exec_role.arn

  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)

  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
    }
  }
}

output "lambda_function_name" {
  value = aws_lambda_function.lambda.function_name
}

# API Integration (Lambda)
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id             = var.api_id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.lambda.invoke_arn
  payload_format_version = "1.0" # Configurar explicitamente para o formato 1.0
}

# API Route
resource "aws_apigatewayv2_route" "default_route" {
  api_id    = var.api_id
  route_key = "ANY /${var.route_key}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# Lambda Permission for API Gateway
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_arn}/*/*"
}