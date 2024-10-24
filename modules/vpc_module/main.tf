# VPCの作成
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  # VPCのタグ設定
  tags = {
    Name = var.vpc_name
  }
}

# プライベートサブネットの作成
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.vpc_name}-private-subnet-${substr(var.azs[count.index], -2, 2)}"
  }
}

# パブリックサブネットの作成
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

 # パブリックサブネットのタグ設定
 tags = {
    Name = "${var.vpc_name}-public-subnet-${substr(var.azs[count.index], -2, 2)}"
  }
}

# インターネットゲートウェイの作成
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  # インターネットゲートウェイのタグ設定
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# パブリックルートテーブルの作成
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  # デフォルトルートをインターネットゲートウェイに設定
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  # ルートテーブルのタグ設定
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

# パブリックサブネットにルートテーブルを関連付ける
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


# プライベートルートテーブルの作成
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

# サブネットにルートテーブルを関連付ける
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

# resource "aws_flow_log" "vpc_flow_log_cloudwatch" {
#   count           = var.flow_log_flag ? 1 : 0
#   iam_role_arn    = aws_iam_role.vpc_flow_log_cloudwatch[count.index].arn
#   log_destination = aws_cloudwatch_log_group.vpc_flow_log_cloudwatch[count.index].arn
#   traffic_type    = "ALL"
#   vpc_id          = aws_vpc.this.id
# }

# resource "aws_cloudwatch_log_group" "vpc_flow_log_cloudwatch" {
#   count = var.flow_log_flag ? 1 : 0
#   name  = "${var.vpc_name}-flow-log"
# }

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["vpc-flow-logs.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "vpc_flow_log_cloudwatch" {
#   count              = var.flow_log_flag ? 1 : 0
#   name               = "${var.vpc_name}-flow-log-role"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# data "aws_iam_policy_document" "vpc_flow_log_cloudwatch" {
#   statement {
#     effect = "Allow"

#     actions = [
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#       "logs:DescribeLogGroups",
#       "logs:DescribeLogStreams",
#     ]

#     resources = ["*"]
#   }
# }

# resource "aws_iam_role_policy" "vpc_flow_log_cloudwatch" {
#   count  = var.flow_log_flag ? 1 : 0
#   name   = "${var.vpc_name}-flow-log-role-policy"
#   role   = aws_iam_role.vpc_flow_log_cloudwatch[count.index].id
#   policy = data.aws_iam_policy_document.vpc_flow_log_cloudwatch.json
# }