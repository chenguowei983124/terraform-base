# main.tf
module "aurora_serverless_v2_postgresql" {
  source = "./modules/aurora_postgresql_module"

  cluster_identifier   = "dbcl-dpc-${var.env}-instance"
  db_name              = "dpc_${var.env}_db"
  master_username      = "postgres"
  master_password      = "tMMlUqAAaThtFRl6"
  engine_version       = "16.3"
  instance_class       = "db.serverless"
  vpc_security_group_ids = ["${module.postgresql_sg.security_group_id}"]
  subnet_ids           = module.vpc.private_subnet_ids
  scaling_min_capacity = 1
  scaling_max_capacity = 4
  db_port              = 5432
}
