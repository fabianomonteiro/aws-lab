# resource "aws_ecr_repository" "kotlin_app" {
#   name                 = "kotlin-app"
#   image_tag_mutability = "MUTABLE"
#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }

# output "ecr_repository_url" {
#   value = aws_ecr_repository.kotlin_app.repository_url
# }
