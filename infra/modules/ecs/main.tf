# Criar o Cluster ECS
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

# Criar a Role para o ECS Task
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.cluster_name}-ecs-task-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = { Service = "ecs-tasks.amazonaws.com" }
      }
    ]
  })
}

resource "aws_iam_role_policy" "ecs_task_policy" {
  name   = "ecs-task-ecr-policy"
  role   = aws_iam_role.ecs_task_execution_role.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = "logs:CreateLogGroup",
        Resource = "*"
      }
    ]
  })
}

# Criar a Task Definition
resource "aws_ecs_task_definition" "task" {
  family                   = "${var.cluster_name}-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "kotlin-app"
      image     = var.container_image
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}

resource "aws_security_group" "ecs_service_sg" {
  name        = "ecs-service-sg"
  description = "Security group for ECS service"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Criar o Serviço ECS
resource "aws_ecs_service" "ecs_service" {
  name            = "${var.cluster_name}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "kotlin-app"
    container_port   = 8080
  }

  network_configuration {
    subnets         = var.subnets
    security_groups = [aws_security_group.ecs_service_sg.id]
    assign_public_ip = true
  }

  health_check_grace_period_seconds = 0
  propagate_tags                    = "NONE"
  
  deployment_circuit_breaker {
    enable    = false
    rollback  = false
  }

  deployment_controller {
    type = "ECS"
  }
}

resource "aws_apigatewayv2_integration" "ecs_integration" {
  api_id             = var.api_id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "http://${var.alb_dns_name}"
  connection_type    = "INTERNET"
  integration_method = "GET"
}

resource "aws_apigatewayv2_route" "ecs_route" {
  api_id    = var.api_id
  route_key = "GET /ecs"
  target    = "integrations/${aws_apigatewayv2_integration.ecs_integration.id}"
}
