terraform {
  backend "s3" {
    bucket         = "sugumar-terra-state-bucket"  # Change if the name already exists. 
    key            = "eks/terraform.tfstate"       
    region         = "us-east-1"                   
    encrypt        = true
  }
}
