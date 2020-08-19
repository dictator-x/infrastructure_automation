provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region = "${var.AWS_REGION}"
}

# provider "aws" {
#   region = "${var.AWS_REGION}"
#   shared_credentials_file = "/home/dictator/.aws"
#   profile = "default"
# }

resource "aws_instance" "example" {
  ami = "ami-02354e95b39ca8dec"
  instance_type = "t2.micro"
}
