terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "example" {
  function_name = "getWeatherData2"

  s3_bucket = "weather-data-puetz"
  s3_key    = "v1.0.0/getWeatherData.zip"

  handler = "main.handler"
  runtime = "nodejs14.x"

  role = aws_iam_role.lambda_exec.arn
}

//need to add dynamodb Get access policy
resource "aws_iam_role" "lambda_exec" {
  name = "serverless_example_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_lambda_function" "example2" {
  function_name = "putWeatherData2"

  s3_bucket = "weather-data-puetz"
  s3_key    = "v1.0.0/putWeatherData.zip"

  handler = "main.handler"
  runtime = "nodejs14.x"

  role = aws_iam_role.lambda_exec.arn
}

//need to add dynamodb Get access policy
resource "aws_iam_role" "lambda_exec2" {
  name = "serverless_example_lambda2"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

