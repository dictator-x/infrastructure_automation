variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map
  default = {
    us-east-1 = "ami-02354e95b39ca8dec"
    us-east-2 = "ami-02354e95b39ca8dec"
  }
}
