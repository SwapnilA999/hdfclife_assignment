terraform {
  backend "s3" {
    bucket  = "terraform-assignment-01"
    region  = "ap-southeast-1"
    key     = "terraform.tfstate"
    dynamodb_table = "terraform-locks" 
    encrypt = "true"  	
  }
}
