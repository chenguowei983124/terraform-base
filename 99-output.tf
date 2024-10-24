output "aws_vpc" {
  value = module.vpc.vpc_name
}
output "aws_vpc_pub_subnet" {
  value = module.vpc.public_subnet_ids
}
output "aws_vpc_az" {
  value = module.vpc.azs
}
output "env"{
    value = var.env
}

output "s3_endpoint_id" {
  value = module.s3_endpoint.vpc_endpoint_id
}