terraform {
  backend "s3" {
    bucket         = "kishu-bucket-1"  
    key            = "eks/development/terraform.tfstate"
    region         = "eu-north-1"            
    encrypt        = true
  }
}
