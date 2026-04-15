data "aws_route53_zone" "selected" {
  name         = var.hosted_zone_name
  private_zone = false
}

module "vpc" {
  source = "../../modules/vpc"

  project_name           = var.project_name
  vpc_cidr               = var.vpc_cidr
  az1                    = var.az1
  az2                    = var.az2
  public_subnet_1a_cidr  = var.public_subnet_1a_cidr
  public_subnet_1b_cidr  = var.public_subnet_1b_cidr
  private_subnet_1a_cidr = var.private_subnet_1a_cidr
  private_subnet_1b_cidr = var.private_subnet_1b_cidr
}

module "security" {
  source = "../../modules/security"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  app_port     = var.app_port
}

module "acm" {
  source = "../../modules/acm"

  domain_name = var.app_domain_name
  zone_id     = data.aws_route53_zone.selected.zone_id
}

module "alb" {
  source = "../../modules/alb"

  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security.alb_sg_id
  app_port          = var.app_port
  certificate_arn   = module.acm.certificate_arn
}

module "route53" {
  source = "../../modules/route53"

  zone_id      = data.aws_route53_zone.selected.zone_id
  record_name  = var.app_domain_name
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
}

module "ecr" {
  source = "../../modules/ecr"

  project_name = var.project_name
}

module "ecs" {
  source = "../../modules/ecs"

  project_name       = var.project_name
  aws_region         = var.aws_region
  private_subnet_ids = module.vpc.private_subnet_ids
  ecs_service_sg_id  = module.security.ecs_service_sg_id
  target_group_arn   = module.alb.target_group_arn
  container_image    = "${module.ecr.repository_url}:latest"
  container_port     = var.app_port
  desired_count      = 2
  uploads_bucket_arn  = module.s3.bucket_arn
  uploads_bucket_name = module.s3.bucket_name
}

module "s3" {
  source = "../../modules/s3"

  project_name = var.project_name
  bucket_name  = var.uploads_bucket_name
}

module "lambda" {
  source = "../../modules/lambda"

  project_name         = var.project_name
  lambda_function_name = var.lambda_function_name
  lambda_zip_path      = "../../../lambda/upload/upload.zip"
  upload_bucket_name   = module.s3.bucket_name
}

module "sns" {
  source = "../../modules/sns"

  project_name = var.project_name
  alert_email  = var.alert_email
}

module "cloudwatch" {
  source = "../../modules/cloudwatch"

  project_name            = var.project_name
  ecs_cluster_name        = module.ecs.cluster_name
  ecs_service_name        = module.ecs.service_name
  alb_arn_suffix          = module.alb.alb_arn_suffix
  target_group_arn_suffix = module.alb.target_group_arn_suffix
  alarm_actions           = [module.sns.topic_arn]
}