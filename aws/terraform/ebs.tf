resource "aws_ebs_volume" "ebs_volume_20_GP2" {
  availability_zone = "us-east-1a"
  size = 20
  type = "gp2"

  tags = {
    Name = "ebs_volume_20_GP2"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs_volume_20_GP2.id
  instance_id = aws_instance.helloword.id
}
