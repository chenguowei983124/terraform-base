# AWSリージョンの設定
variable "region" {
  description = "リソースを作成するAWSリージョン"
  type        = string
}

# VPCのid
variable "vpc_id" {
  description = "VPCのid"
  type        = string
}

# ペアリングVPCのid
variable "peering_vpc_id" {
  description = "VPCのid"
  type        = string
}

# ペアリング先のアカウントid
variable "peering_accout_id" {
  description = "ペアリング先のアカウントid"
  type        = string
}

# ペアリング先のアカウントid
variable "tag_name" {
  description = "ペアリング先のアカウントid"
  type        = string
}