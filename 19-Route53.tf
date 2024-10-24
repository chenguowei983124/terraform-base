module "snowflake_private_zone" {
  source = "./modules/route53_private_zone"

  zone_name = "ap-northeast-1.privatelink.snowflakecomputing.com"
  vpc_id    = module.vpc.vpc_id

  records = {
    "record1" = {
      name   = "app.ap-northeast-1.privatelink.snowflakecomputing.com"
      type   = "CNAME"
      ttl    = 300
      record = module.snowfalke_endpoint.vpc_endpoint_dns_entry[0].dns_name
    }
    "record2" = {
      name   = "oahthzc-ex88666.ap-northeast-1.privatelink.snowflakecomputing.com"
      type   = "CNAME"
      ttl    = 300
      record = module.snowfalke_endpoint.vpc_endpoint_dns_entry[0].dns_name
    }
    "record3" = {
      name   = "ot06403.ap-northeast-1.privatelink.snowflakecomputing.com"
      type   = "CNAME"
      ttl    = 3600
      record = module.snowfalke_endpoint.vpc_endpoint_dns_entry[0].dns_name
    }
    "record4" = {
      name   = "ocsp.ot06403.ap-northeast-1.privatelink.snowflakecomputing.com"
      type   = "CNAME"
      ttl    = 3600
      record = module.snowfalke_endpoint.vpc_endpoint_dns_entry[0].dns_name
    }
  }

  comment = "Private hosted zone for example.com"
}