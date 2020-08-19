variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  description = "AWS region to launch servers"
  default = "us-east-1"
}

variable "INITIAL_SCRIPT" {}
variable "PATH_TO_PRIVATE_KEY" {}
variable "PATH_TO_PUBLIC_KEY" {}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-02354e95b39ca8dec"
    us-east-2 = "ami-02354e95b39ca8dec"
  }
}

variable "VM_TYPE" {
  type = string
  default = "AmazonLinux"
}

variable "VM_DEFAULT_USERNAME" {
  type = map(string)
  default = {
    AmazonLinux = "ec2-user"
    Ubuntu = "ubuntu"
  }
}

