terraform {
  required_version = "~> 0.12.0"
}

provider "aws" {
  #CI config
  #AWS_ACCESS_KEY_ID="anaccesskey"
  #AWS_SECRET_ACCESS_KEY="asecretkey"
  version = "~> 2.0"
  region  = "us-west-2"
  profile = "personal"
}
