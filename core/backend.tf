terraform {
  backend "s3" {
    bucket       = "petclinic-tfstate-159528311901"
    key          = "petclinic/core/terraform.tfstate"
    region       = "ap-south-2"
    use_lockfile = true
    encrypt      = true
  }
}
