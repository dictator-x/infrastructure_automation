data "aws_route53_zone" "xrw_io" {
  name = "xrw.io"
}

resource "aws_route53_record" "coturn_xrw_io" {
  zone_id = data.aws_route53_zone.xrw_io.zone_id
  name    = "coturn.xrw.io"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.helloword_public_ip.public_ip]
}

output "gruums_servers" {
  value = data.aws_route53_zone.xrw_io.name_servers
}
