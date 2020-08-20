resource "aws_key_pair" "temp_key" {
  key_name = "temp_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "helloword" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.temp_key.key_name
  subnet_id = aws_subnet.my-vpc-public-1.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_http_tls.id]
  tags = {
    Name = "Helloword"
  }

  root_block_device {
    volume_size = 16
    volume_type = "gp2"
    delete_on_termination = true
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
    user = lookup(var.VM_DEFAULT_USERNAME, var.VM_TYPE)
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}
