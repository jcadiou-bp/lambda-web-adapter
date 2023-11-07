output "summary" {
  value = {
    env     = var.env
    project = var.project
    graphql_lambda_url = aws_lambda_function_url.graphql.function_url
  }
}
