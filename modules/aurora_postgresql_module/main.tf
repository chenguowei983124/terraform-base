# modules/aurora-serverless-v2-postgresql/main.tf
resource "aws_rds_cluster" "aurora_postgresql" {
  cluster_identifier      = var.cluster_identifier
  engine                  = "aurora-postgresql"
  engine_mode             = "provisioned" 
  engine_version          = var.engine_version
  master_username         = var.master_username
  master_password         = var.master_password
  database_name           = var.db_name
  skip_final_snapshot     = true
  vpc_security_group_ids  = var.vpc_security_group_ids
  db_subnet_group_name    = aws_db_subnet_group.aurora_postgresql_subnet_group.name
  port                    = var.db_port

  serverlessv2_scaling_configuration {
    min_capacity = var.scaling_min_capacity
    max_capacity = var.scaling_max_capacity
  }

  tags = var.tags
}

resource "aws_rds_cluster_instance" "aurora_postgresql_instance" {
  count                = var.instance_count
  cluster_identifier   = aws_rds_cluster.aurora_postgresql.id
  instance_class       = var.instance_class
  engine               = aws_rds_cluster.aurora_postgresql.engine
  engine_version       = aws_rds_cluster.aurora_postgresql.engine_version
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.aurora_postgresql_subnet_group.name
  tags                 = var.tags
}

resource "aws_db_subnet_group" "aurora_postgresql_subnet_group" {
  name       = "${var.cluster_identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = var.tags
}
