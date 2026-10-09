locals {
  name_prefix = "${var.project_name}-${var.environment}"

  # Placeholder for first deploy before you push your own image.
  # Replace via var.container_image after `docker build/push` to ECR.
  default_image   = "public.ecr.aws/docker/library/httpd:2.4-alpine"
  container_image = var.container_image != "" ? var.container_image : local.default_image
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "vpc" {
  source      = "./modules/vpc"
  name_prefix = local.name_prefix
  vpc_cidr    = var.vpc_cidr
}

module "ecr" {
  source      = "./modules/ecr"
  name_prefix = local.name_prefix
  keep_images = var.ecr_keep_images
}

module "iam" {
  source      = "./modules/iam"
  name_prefix = local.name_prefix
}

module "alb" {
  source            = "./modules/alb"
  name_prefix       = local.name_prefix
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  container_port    = var.container_port
  health_check_path = "/health"
}

module "ecs" {
  source                = "./modules/ecs"
  name_prefix           = local.name_prefix
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  alb_security_group_id = module.alb.security_group_id
  target_group_arn      = module.alb.target_group_arn
  execution_role_arn    = module.iam.execution_role_arn
  task_role_arn         = module.iam.task_role_arn
  container_image       = local.container_image
  container_port        = var.container_port
  task_cpu              = var.task_cpu
  task_memory           = var.task_memory
  desired_count         = var.desired_count
  assign_public_ip      = var.assign_public_ip
  log_retention_days    = var.log_retention_days
  aws_region            = var.aws_region
  environment           = var.environment
}

module "autoscaling" {
  source           = "./modules/autoscaling"
  name_prefix      = local.name_prefix
  cluster_name     = module.ecs.cluster_name
  service_name     = module.ecs.service_name
  min_capacity     = var.min_capacity
  max_capacity     = var.max_capacity
  cpu_target_value = var.cpu_target_percent
}
