data "archive_file" "graphql_package" {
  type        = "zip"
  source_dir  = "../dist"
  output_path = "graphql.zip"
}

resource "aws_lambda_function" "graphql" {
  filename         = data.archive_file.graphql_package.output_path
  function_name    = "${var.project}-${var.env}-graphql"
  role             = aws_iam_role.lambda_web.arn
  handler          = "run.sh"
  runtime          = "nodejs18.x"
  architectures    = ["x86_64"]
  layers           = ["arn:aws:lambda:eu-west-2:753240598075:layer:LambdaAdapterLayerX86:17"]
  memory_size      = 256
  timeout          = 30
  source_code_hash = data.archive_file.graphql_package.output_base64sha256
  environment {
    variables = {
      "AWS_LAMBDA_EXEC_WRAPPER" = "/opt/bootstrap",
      "RUST_LOG"                = "info",
      "PORT"                    = "4005",
      "NODE_ENV"                = "production"
    }
  }
}

resource "aws_lambda_function_url" "graphql" {
  function_name      = aws_lambda_function.graphql.function_name
  authorization_type = "NONE"
}
