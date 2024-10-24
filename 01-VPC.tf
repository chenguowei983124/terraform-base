#vpc定義
module "vpc" {
  source = "./modules/vpc_module"

  region              = var.aws_region
  azs                 = var.vpc_azs
  vpc_name            = "${var.APP_NAME}-${var.env}"
  cidr_block          = var.vpc_cidr_block  
  private_subnet_cidrs = var.vpc_private_subnets
  public_subnet_cidrs = var.vpc_public_subnets
}

# module "flow_log" {
#   source = "./modules/vpc_flow_logs"

#   vpc_name            = "${var.APP_NAME}-${var.env}"
#   vpc_id = module.vpc.vpc_id
# }

# module "peering" {
#   source = "./modules/peering_module"

#   vpc_id = module.vpc.vpc_id
#   peering_accout_id = "535602314265"        #ピアリング接続先アカウントID
#   peering_vpc_id = "vpc-00c20db2bcc5be22d"  #ピアリング接続先VPC ID
#   region = var.aws_region
#   tag_name = "${var.APP_NAME}-${var.env}-${var.peering_vpc_name}"
# }

#snowflakeとPrivate接続endpoint用SecurityGroup
module "snowflake_endpoint_sg" {
  source = "./modules/vpc_security_group_module"

  name                 = "${var.APP_NAME}-${var.env}-snowflake-endpoint-sg"
  description          = "Security group for web servers"
  vpc_id               = "${module.vpc.vpc_id}"
# 
   ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"  # All traffic
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Name        = "${var.APP_NAME}-${var.env}-endpoint-sg"
    Environment = "${var.env}"
  }
}

#postgresql用SecurityGroup
module "postgresql_sg" {
  source = "./modules/vpc_security_group_module"

  name                 = "${var.APP_NAME}-${var.env}-postgresql-sg"
  description          = "Security group for postgresql"
  vpc_id               = "${module.vpc.vpc_id}"

   ingress_rules = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"  # All traffic
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Name        = "${var.APP_NAME}-${var.env}-postgresql-sg"
    Environment = "${var.env}"
  }
}


#汎用endpoint用SecurityGroup
module "endpoint_sg" {
  source = "./modules/vpc_security_group_module"

  name                 = "${var.APP_NAME}-${var.env}-endpoint-sg"
  description          = "Security group for web servers"
  vpc_id               = "${module.vpc.vpc_id}"

   ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"  # All traffic
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Name        = "${var.APP_NAME}-${var.env}-endpoint-sg"
    Environment = "${var.env}"
  }
}

#s3 endpoint
module "s3_endpoint" {
  source = "./modules/vpc_endpoint_module"

  vpc_id            = "${module.vpc.vpc_id}"
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = ["${module.vpc.private_route_table}"]
  private_dns_enabled = false

  tags = {
    Name        = "${var.APP_NAME}-${var.env}-s3-gateway-endpoint"
    Environment = "${var.env}"
  }
}

#ecr dkr endpoint
module "ecr_dkr_endpoint" {
  source = "./modules/vpc_endpoint_module"

  vpc_id            = "${module.vpc.vpc_id}"
  service_name      = "com.amazonaws.${var.aws_region}.ecr.dkr"
  
  vpc_endpoint_type = "Interface"
  security_group_ids = ["${module.endpoint_sg.security_group_id}"]
  subnet_ids = module.vpc.private_subnet_ids
  tags = {
    Name        = "${var.APP_NAME}-${var.env}-ecr-dkr-endpoint"
    Environment = "${var.env}"
  }
}

#ecr endpoint
module "ecr_api_endpoint" {
  source = "./modules/vpc_endpoint_module"

  vpc_id            = "${module.vpc.vpc_id}"
  service_name      = "com.amazonaws.${var.aws_region}.ecr.api"
  vpc_endpoint_type = "Interface"
  security_group_ids = ["${module.endpoint_sg.security_group_id}"]
  subnet_ids = module.vpc.private_subnet_ids
  tags = {
    Name        = "${var.APP_NAME}-${var.env}-ecr-api-endpoint"
    Environment = "${var.env}"
  }
}

#ecs endpoint
module "ecs_endpoint" {
  source = "./modules/vpc_endpoint_module"

  vpc_id            = "${module.vpc.vpc_id}"
  service_name      = "com.amazonaws.${var.aws_region}.ecs"
  vpc_endpoint_type = "Interface"
  security_group_ids = ["${module.endpoint_sg.security_group_id}"]
  subnet_ids = module.vpc.private_subnet_ids
  tags = {
    Name        = "${var.APP_NAME}-${var.env}-ecs-endpoint"
    Environment = "${var.env}"
  }
}

#snowflake endpoint
module "snowfalke_endpoint" {
  source = "./modules/vpc_endpoint_module"

  vpc_id              = "${module.vpc.vpc_id}"
  service_name        = "com.amazonaws.vpce.ap-northeast-1.vpce-svc-04feb508c997b211e"
  private_dns_enabled = false
  vpc_endpoint_type   = "Interface"
  security_group_ids  = ["${module.snowflake_endpoint_sg.security_group_id}"]
  subnet_ids = module.vpc.private_subnet_ids
  tags = {
    Name        = "${var.APP_NAME}-${var.env}-snowfalke-endpoint"
    Environment = "${var.env}"
  }
}

# Create Client VPN Endpoint
resource "aws_ec2_client_vpn_endpoint" "vpn_endpoint" {
  client_cidr_block = "10.0.0.0/16"
  server_certificate_arn = aws_acm_certificate.vpn_server_cert.arn

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.vpn_server_cert.arn 
  }

  connection_log_options {
    enabled = false
  }
  split_tunnel = true  # スプリットトンネルを有効にする
  dns_servers = ["172.10.0.2"] # DNS service setting(オプション)
  transport_protocol = "udp"

  tags = {
    Name = "${var.APP_NAME}-${var.env}-client-vpn-endpoint"
  }
}

# VPN Target Network Association
resource "aws_ec2_client_vpn_network_association" "client_vpn_association" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn_endpoint.id
  subnet_id              = module.vpc.private_subnet_ids[0]
}

# Create authorization rule
resource "aws_ec2_client_vpn_authorization_rule" "client_vpn_auth_rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn_endpoint.id
  target_network_cidr    = module.vpc.vpc_cidr_block 
  authorize_all_groups   = true
}

