resource "aws_dynamodb_table" "terraform_locks" {
  name           = "terraform-lock-table"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform locks"
    Environment = "Dev"
  }
}
