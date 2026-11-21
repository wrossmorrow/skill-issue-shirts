variable "domain" {
  description = "Apex domain the site is served at, e.g. skillissueshirts.com"
  type        = string
}

variable "include_www" {
  description = "Also serve www.<domain>; it 301-redirects to the apex"
  type        = bool
  default     = true
}

variable "region" {
  description = "Region for the content bucket"
  type        = string
  default     = "us-west-2"
}

variable "bucket_prefix" {
  description = "Content bucket name before the region suffix; defaults to <domain with dashes>-site. The bucket is named <prefix>-<region code>, e.g. -usw2."
  type        = string
  default     = null
}

variable "manage_dns" {
  description = "Look up the public Route 53 zone for var.domain and manage cert validation and alias records in it. Set false if DNS lives elsewhere."
  type        = bool
  default     = true
}

variable "price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"
}

variable "tags" {
  type    = map(string)
  default = { project = "skill-issue-shirts" }
}
