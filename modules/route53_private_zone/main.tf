resource "aws_route53_zone" "private_zone" {
  name = var.zone_name

  vpc {
    vpc_id = var.vpc_id
  }

  comment = var.comment
}

resource "aws_route53_record" "record" {
  for_each = var.records

  zone_id = aws_route53_zone.private_zone.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  records = [each.value.record]
}
