provider "aws" {
  access_key = "AKIAS2FXETXZG7XQR5VU"
  secret_key = "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"
  region     = var.aws_region
  #if you are running from AWS ec2 linux instance please use bellow credentials section
  #shared_credentials_file = "$HOME/.aws/credentials"
  #profile = "MyAWS"
}
