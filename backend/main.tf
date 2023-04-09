# Set up the provider
provider "aws" {
  region = "us-east-1"
}

# Create a Lambda function for saving a Todo
resource "aws_lambda_function" "save_todo" {
  function_name = "save_todo"
  handler       = "save_todo.handler"
  runtime       = "nodejs14.x"
  filename      = "save_todo.zip"
  role          = aws_iam_role.save_todo.arn

  environment {
    variables = {
      DB_CLUSTER_ARN = aws_rds_cluster.database_cluster.arn
      DB_SECRET_ARN  = aws_secretsmanager_secret.database_credentials.arn
    }
  }

  # You can add any other configuration here, such as VPC settings or memory allocation
}

# Create a Lambda function for retrieving a Todo
resource "aws_lambda_function" "get_todo" {
  function_name = "get_todo"
  handler       = "get_todo.handler"
  runtime       = "nodejs14.x"
  filename      = "get_todo.zip"
  role          = aws_iam_role.get_todo.arn

  environment {
    variables = {
      DB_CLUSTER_ARN = aws_rds_cluster.database_cluster.arn
      DB_SECRET_ARN  = aws_secretsmanager_secret.database_credentials.arn
    }
  }

  # You can add any other configuration here, such as VPC settings or memory allocation
}

# Create a Lambda function for retrieving all Todos for a given user
resource "aws_lambda_function" "get_todos_for_user" {
  function_name = "get_todos_for_user"
  handler       = "get_todos_for_user.handler"
  runtime       = "nodejs14.x"
  filename      = "get_todos_for_user.zip"
  role          = aws_iam_role.get_todo.arn

  environment {
    variables = {
      DB_CLUSTER_ARN = aws_rds_cluster.database_cluster.arn
      DB_SECRET_ARN  = aws_secretsmanager_secret.database_credentials.arn
    }
  }

  # You can add any other configuration here, such as VPC settings or memory allocation
}

# Create an IAM role for the Lambda functions
resource "aws_iam_role" "save_todo" {
  name = "save_todo"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role" "get_todo" {
  name = "get_todo"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
