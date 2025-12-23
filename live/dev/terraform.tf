terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"

  # Exam-style pattern for remote state:
  # backend "s3" {
  #   bucket         = "my-tfstate-bucket"
  #   key            = "learn-terraform/dev/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "my-tf-locks"
  #   encrypt        = true
  # }
}
