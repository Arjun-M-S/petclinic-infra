terraform {
  backend "s3" {
    bucket         = "petclinic-tfstate-159528311901"
    key            = "petclinic/terraform.tfstate"
    region         = "ap-south-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
