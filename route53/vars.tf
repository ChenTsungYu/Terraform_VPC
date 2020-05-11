variable "AWS_REGION" {
  default = "us-east-2"
}

variable "aws_key_pair" { # read key pair
  default = "./aws_key_pair/tom-terraform.pem"
}
