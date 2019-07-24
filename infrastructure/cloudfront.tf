resource "aws_cloudfront_distribution" "distribution" {
  enabled         = true
  price_class     = "PriceClass_100"
  http_version    = "http2"
  is_ipv6_enabled = true
  aliases         = ["*.ryanmeis.dev"]
  origin {
    origin_id   = "origin-bucket-${aws_s3_bucket.site.id}"
    domain_name = "${aws_s3_bucket.site.website_endpoint}"
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only" # Required if s3 backend
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }
  default_root_object = local.pagename
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "origin-bucket-${aws_s3_bucket.site.id}"
    min_ttl                = "0"
    default_ttl            = "300"
    max_ttl                = "1200"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    #cloudfront_default_certificate = true
    #iam_certificate_id       = "acm_certificate_arn"
    acm_certificate_arn      = "arn:aws:acm:us-east-1:732262869685:certificate/9c45d5c1-ec9e-4f1d-a581-eba98c674ed8"
    ssl_support_method       = "sni-only" # vip gives static ip but costs more
    minimum_protocol_version = "TLSv1.2_2018"
  }
}
