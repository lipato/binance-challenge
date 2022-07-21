data "aws_route53_zone" "this" {
  name         = var.env.domain_zone
}

resource "aws_route53_record" "a-record" {
  zone_id = data.aws_route53_zone.this.id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.dns_name
    zone_id                = var.zone_id
    evaluate_target_health = true
  }
}
