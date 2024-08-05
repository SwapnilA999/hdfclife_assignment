terraform {
  backend "s3" {
    bucket         = "remote-backend-bucket-2024"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
                                  
