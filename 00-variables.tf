
# variable "aws_availability_zones" {
#   type    = list(string)
#   default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
# }

# # AWS EC2 Instance Type
# variable "instance_type" {
#   type    = string
#   default = "t3.micro"
# }

# # AWS EC2 Image ID
# variable "instance_ami_id" {
#   description = "AMI Image ID"
#   type        = string
#   default     = "ami-0218d08a1f9dac831"
# }

# # AWS EC2 Instance Key Pair
# variable "instance_keypair" {
#   type    = string
#   default = "terraform-test-ssh-key"
# }

# # variable "vpc_env" {}
# # variable "vpc_cidr" {}
# # variable "vpc_azs" {}
# # variable "vpc_public_subnets" {
# #   type = list(string)
# # }
# # variable "vpc_private_subnets" {
# #   type = list(string)
# # }
# # variable "vpc_database_subnets" {
# #   type = list(string)
# # }

# locals {
#   prefix_name= "${var.APP_NAME}-${var.env}"
#   #############################################################################
#   # VPC
#   vpc_name            = "${var.APP_NAME}-${var.env}"
#   vpc_azs             = var.aws_availability_zones
#   vpc_cidr            = "172.16.0.0/16"
#   vpc_public_subnets  = ["172.16.1.0/24", "172.16.2.0/24"]
#   vpc_private_subnets = ["172.16.3.0/24", "172.16.4.0/24"]
#   # vpc_database_subnets = ["172.16.5.0/24", "172.16.6.0/24"]
#   #############################################################################
#   # Security Group
#   sg_name = "${var.APP_NAME}-${var.env}"

#   #############################################################################
#   # EC2
#   ec2_name          = "${var.APP_NAME}-xxx-ec2"
#   ec2_instance_type = var.env == "prod" ? "t3.large" : "t3.micro"
#   ec2_key_name      = "komavideo-ssh-key"

#   #############################################################################
#   # S3
#   s3_name_prifix = "${var.APP_NAME}-s3"

#   #############################################################################
  
#   # Tag
#   #############################################################################
#   common_tags = {
#     Owner = var.APP_NAME
#     Env   = var.env
#   }
#   #############################################################################
  
# }

# 案件名
variable "APP_NAME" {
  default = "ncchd-dpc"
}

# 環境の種類
variable "env" {
  description = "環境の種類（dev,stg,prod）"
  type        = string
  default = "dev" 
}

# AWS Region
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-1"
}

# サブネットを作成する可用性ゾーンのリストを定義する変数
variable "vpc_azs" {
  description = "サブネットを作成する可用性ゾーンのリスト"
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1c"]
}

# VPCの名前を定義する変数
variable "vpc_name" {
  description = "VPCの名前"
  type        = string
  default     = "ncchd-dpc-vpc"
}

# VPCのCIDRブロックを定義する変数
variable "vpc_cidr_block" {
  description = "VPCのCIDRブロック"
  type        = string
  default     = "172.10.0.0/16"
}

# パブリックサブネットのCIDRブロックを定義する変数
variable "vpc_public_subnets" {
  description = "パブリックサブネットのCIDRブロックのリスト"
  type        = list(string)
  default     = ["172.10.1.0/24", "172.10.2.0/24"]
}

# プライベートサブネットのCIDRブロックを定義する変数
variable "vpc_private_subnets" {
  description = "プライベートサブネットのCIDRブロックのリスト"
  type        = list(string)
  default     = ["172.10.3.0/24", "172.10.4.0/24"]
}


# NATゲートウェイを有効にするかどうか
variable "enable_nat_gateway" {
  description = "NATゲートウェイを有効にするかどうか"
  type        = bool
  default     = false
}

# シングルNATゲートウェイを使用するかどうか
variable "single_nat_gateway" {
  description = "シングルNATゲートウェイを使用するかどうか"
  type        = bool
  default     = false
}

# 各可用性ゾーンごとにNATゲートウェイを作成するかどうか
variable "one_nat_gateway_per_az" {
  description = "各可用性ゾーンごとにNATゲートウェイを作成するかどうか"
  type        = bool
  default     = false
}

# DNSホスト名を有効にするかどうか
variable "enable_dns_hostnames" {
  description = "DNSホスト名を有効にするかどうか"
  type        = bool
  default     = true
}

# DNSサポートを有効にするかどうか
variable "enable_dns_support" {
  description = "DNSサポートを有効にするかどうか"
  type        = bool
  default     = true
}

# タグの定義
variable "tags" {
  description = "VPCとその関連リソースに適用するタグのマップ"
  type        = map(string)
  default     = {
    "Environment" = "dev"
    "Owner"       = "ncchd-hhc"
  }
}

# ペアリングVPCのid
variable "peering_vpc_id" {
  description = "peeringのvpcのid"
  type        = string
}
# ペアリングVPCのname
variable "peering_vpc_name" {
  description = "peeringのvpcのname"
  type        = string
}
# ペアリング先のアカウントid
variable "peering_accout_id" {
  description = "ペアリング先のアカウントid"
  type        = string
}