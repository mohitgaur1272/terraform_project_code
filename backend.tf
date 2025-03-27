terraform {
  backend "s3" {
    bucket         = "mohit-terraform-state-2025"
    key            = "terraform/terraform-statefile"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "mohit-terraform-lock"
  }
}
