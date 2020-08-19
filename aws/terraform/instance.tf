resource "aws_key_pair" "temp_key" {
  key_name = "temp_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "helloword" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.temp_key.key_name
  tags = {
    Name = "Helloword"
  }

  provisioner "file" {
    source = var.INITIAL_SCRIPT
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {
    host = self.public_ip
    # user = "root"
    user = "ec2-user"
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}
