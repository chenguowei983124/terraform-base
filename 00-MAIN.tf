# Terraform 基本設定
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.60"
    }
  }

  required_version = ">= 1.0"
}

# 提供元
provider "aws" {
  profile = "ncchd-dpc-admin"
  region  = var.aws_region
}

# ステータスファイルの置き場を設定する
terraform {
  backend "s3" {
    bucket = "ncchd-terraform-state"
    key    = "ncchd-dpc/terraform.tfstate"
    region = "ap-northeast-1"
    profile = "ncchd-dpc-root"
  }
}