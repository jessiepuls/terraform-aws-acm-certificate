data "aws_route53_zone" "selected" {
  name = "${var.root_domain_name}."
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.root_domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  subject_alternative_names = var.alternative_names
}

resource "aws_route53_record" "validation_record_0" {
  # for_each        = aws_acm_certificate.cert.domain_validation_options
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.cert.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.selected.zone_id
  ttl             = 60
}

resource "aws_route53_record" "validation_record_1" {
  # for_each        = aws_acm_certificate.cert.domain_validation_options
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.cert.domain_validation_options)[1].resource_record_name
  records         = [tolist(aws_acm_certificate.cert.domain_validation_options)[1].resource_record_value]
  type            = tolist(aws_acm_certificate.cert.domain_validation_options)[1].resource_record_type
  zone_id         = data.aws_route53_zone.selected.zone_id
  ttl             = 60
}
