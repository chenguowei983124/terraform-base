# AWSリージョンの設定
variable "region" {
  description = "リソースを作成するAWSリージョン"
  type        = string
}

# VPCの名前
variable "vpc_name" {
  description = "VPCの名前"
  type        = string
}

# VPCのCIDRブロック
variable "cidr_block" {
  description = "VPCのCIDRブロック"
  type        = string
}

# プライベートサブネット用のCIDRブロックのリスト
variable "private_subnet_cidrs" {
  description = "プライベートサブネットのCIDRブロックのリスト"
  type        = list(string)
}

# パブリックサブネット用のCIDRブロックのリスト
variable "public_subnet_cidrs" {
  description = "パブリックサブネットのCIDRブロックのリスト"
  type        = list(string)
}

# サブネットを作成する可用性ゾーンのリスト
variable "azs" {
  description = "サブネットを作成する可用性ゾーンのリスト"
  type        = list(string)
}
