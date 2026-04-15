variable "domain_name" {
  description = "Fully qualified domain name for the certificate"
  type        = string
}

variable "zone_id" {
  description = "Route 53 hosted zone ID used for DNS validation"
  type        = string
}