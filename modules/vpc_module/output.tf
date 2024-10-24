# VPCのIDを出力
output "vpc_id" {
  description = "VPCのID"
  value       = aws_vpc.this.id
}

# VPCの名前を出力
output "vpc_name" {
  description = "VPCのID"
  value       = aws_vpc.this.tags["Name"]
}

# プライベートサブネットのIDリストを出力
output "private_subnet_ids" {
  description = "プライベートサブネットのID"
  value       = aws_subnet.private[*].id
}

# パブリックサブネットのIDリストを出力
output "public_subnet_ids" {
  description = "パブリックサブネットのID"
  value       = aws_subnet.public[*].id
}

# インターネットゲートウェイのIDを出力
output "internet_gateway_id" {
  description = "インターネットゲートウェイのID"
  value       = aws_internet_gateway.this.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}

output "azs" {
  description = "The availability zones used by the subnets"
  value       = aws_subnet.public[*].availability_zone
}

# プライベートルートテーブルのIDを出力
output "private_route_table" {
  description = "The private route table id"
  value       = aws_route_table.private.id
}