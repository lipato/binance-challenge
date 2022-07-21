provider "aws" {
  region                 = var.env.region
}

### === create network
module "network" {
  source                 = "../modules/network"
  subnets                = var.subnets
  vpc_cidr               = var.account.vpc_cidr
  env                    = var.env
}

# === create kms key
module "kms" {
  source                 = "../modules/kms"
  env                    = var.env
}

# === create ecr repository for images
module "ecr" {
  source                 = "../modules/ecr"
  name                   = var.ecr_name
  accounts               = [ var.account.id ]
  kms_key                = module.kms.kms-key.arn
  env                    = var.env
}

# === create certificate
module "certificate" {
  source                 = "../modules/certificate"
  domain_name            = "${var.env.domain_name}.${var.env.domain_zone}"
}

# === create ecs cluster
module "ecs" {
  source                 = "../modules/ecs"
  certificate_arn        = module.certificate.arn
  ecs_security_groups    = [ module.network.ecs-security-group ]
  private_subnets        = [ module.network.private-subnet-a, module.network.private-subnet-b ]
  public_security_groups = [ module.network.public-alb-security-group ]
  docker-image           = "${var.account.id}.dkr.ecr.${var.env.region}.amazonaws.com/${var.ecr_name}"
  public_subnets         = [ module.network.public-subnet-a, module.network.public-subnet-b ]
  vpc_id                 = module.network.vpc.id
  env                    = var.env
}

# === add domain to zone and connect to alb
module "route53" {
  source                 = "../modules/route53"
  domain_name            = "${var.env.domain_name}.${var.env.domain_zone}"
  dns_name               = module.ecs.alb_dns_name
  zone_id                = module.ecs.alb_zone_id
  env                    = var.env
}