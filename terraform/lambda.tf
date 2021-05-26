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

resource "aws_lambda_function" "getWeatherDataLambda" {
  function_name = "getWeatherData"

  s3_bucket = "weather-data-puetz"
  s3_key    = "v1.0.0/getWeatherData/index.zip"

  handler = "main.handler"
  runtime = "nodejs14.x"

  role = aws_iam_role.getWeatherDataLambdaIAM.arn
}

//need to add dynamodb Get access policy
resource "aws_iam_role" "getWeatherDataLambdaIAM" {
  name = "getWeatherData"

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

resource "aws_lambda_function" "putWeatherDataLambda" {
  function_name = "putWeatherData"

  s3_bucket = "weather-data-puetz"
  s3_key    = "v1.0.0/putWeatherData/index.zip"

  handler = "main.handler"
  runtime = "nodejs14.x"

  role = aws_iam_role.putWeatherDataLambdaIAM.arn
}

//need to add dynamodb Get access policy
resource "aws_iam_role" "putWeatherDataLambdaIAM" {
  name = "putWeatherData"

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

resource "aws_dynamodb_table" "weatherTable" {
  name     = "Weather"
  hash_key = "id"
  write_capacity = "5"
  read_capacity = "5"

  attribute {
    name = "id"
    type = "N"
  }
}

