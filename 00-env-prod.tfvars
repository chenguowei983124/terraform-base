env="prd"

APP_NAME = "ncchd-dpc"
vpc_cidr_block  = "172.10.0.0/16"

vpc_azs              = ["ap-northeast-1a", "ap-northeast-1c"]
vpc_public_subnets   = ["172.10.10.0/24", "172.10.11.0/24"]
vpc_private_subnets  = ["172.10.20.0/24", "172.10.21.0/24"]

peering_accout_id = "999999999999"
peering_vpc_name = "ncchd"
peering_vpc_id = "vpc-0dexxxxxxxxxxxx"