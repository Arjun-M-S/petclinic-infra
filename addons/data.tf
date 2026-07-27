data "terraform_remote_state" "core" {
  backend = "s3"
  config = {
    bucket = "petclinic-tfstate-159528311901"
    key    = "petclinic/core/terraform.tfstate"
    region = "ap-south-2"
  }
}

data "aws_eks_cluster_auth" "this" {
  name = data.terraform_remote_state.core.outputs.cluster_name
}
