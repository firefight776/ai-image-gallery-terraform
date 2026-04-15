variable "zone_id" {
  description = "Hosted zone ID"
  type        = string
}

variable "record_name" {
  description = "Record name to create"
  type        = string
}

variable "alb_dns_name" {
  description = "ALB DNS name"
  type        = string
}

variable "alb_zone_id" {
  description = "ALB hosted zone ID"
  type        = string
}