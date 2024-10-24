env      = "dev"
APP_NAME = "ncchd-dpc"
vpc_cidr_block  = "172.10.0.0/16"

vpc_azs              = ["ap-northeast-1a", "ap-northeast-1c"]
vpc_public_subnets   = ["172.10.10.0/24", "172.10.11.0/24"]
vpc_private_subnets  = ["172.10.20.0/24", "172.10.21.0/24"]

peering_accout_id = "535602314265"
peering_vpc_name = "ncchd-dev"
peering_vpc_id = "vpc-0de32ff2d96a9e5fa"
# vpc_private_subnets_ecs  = ["20.0.103.0/24", "20.0.104.0/24"]
# vpc_database_subnets = ["20.0.201.0/24", "20.0.202.0/24"]