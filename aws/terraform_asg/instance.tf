resource "aws_key_pair" "temp_key" {
  key_name = "temp_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_eip" "bastion_public_ip" {
  vpc = true
  instance = aws_instance.bastion.id
  tags = {
    Name = "bastion_public_ip"
  }
}

resource "aws_instance" "bastion" {
  ami = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name = aws_key_pair.temp_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh_http_tls.id]
  subnet_id = aws_subnet.public_subnet_1.id

  tags = {
    Name = "bastion"
  }

  # user_data = data.template_file.helloworld_http_server_script.rendered
  # user_data = file(var.INITIAL_SCRIPT)

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

data "aws_ami" "centos" {
  owners      = ["125523088429"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS 7.8.2003 x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "centos" {
  value = data.aws_ami.centos.id
}
