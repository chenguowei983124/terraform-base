# main.tf in vpc-endpoint-module

resource "aws_vpc_endpoint" "this" {
  vpc_id             = var.vpc_id
  service_name       = var.service_name
  vpc_endpoint_type  = var.vpc_endpoint_type
  private_dns_enabled = var.private_dns_enabled
  security_group_ids = var.security_group_ids
  subnet_ids         = var.subnet_ids
  route_table_ids    = var.route_table_ids

  tags = var.tags
}
