#s3バケット定義
module "recv-bucket" {
  source = "./modules/s3_module"

  bucket_name = "${var.APP_NAME}-${var.env}-recv-bucket"
}

module "recv-acc-bucket" {
  source = "./modules/s3_module"

  bucket_name = "${var.APP_NAME}-${var.env}-recv-acc-bucket"
}

module "send-bucket" {
  source = "./modules/s3_module"

  bucket_name = "${var.APP_NAME}-${var.env}-send-bucket"
}

module "logs-bucket" {
  source = "./modules/s3_module"

  bucket_name = "${var.APP_NAME}-${var.env}-logs-bucket"
}

module "mnte-bucket" {
  source = "./modules/s3_module"

  bucket_name = "${var.APP_NAME}-${var.env}-mnte-bucket"
}
