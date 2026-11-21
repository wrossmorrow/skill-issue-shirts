output "bucket_name" {
  description = "SITE_BUCKET for scripts/deploy.sh"
  value       = aws_s3_bucket.site.bucket
}

output "distribution_id" {
  description = "CF_DISTRIBUTION_ID for scripts/deploy.sh"
  value       = aws_cloudfront_distribution.site.id
}

output "distribution_domain" {
  description = "Point your domain here (CNAME/ALIAS) if DNS isn't in Route 53"
  value       = aws_cloudfront_distribution.site.domain_name
}

output "cert_validation_records" {
  description = "Add these to DNS by hand if DNS isn't in Route 53"
  value = local.use_r53 ? [] : [
    for dvo in aws_acm_certificate.site.domain_validation_options : {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  ]
}
