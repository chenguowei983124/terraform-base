# terraform-base


# 1.目录初始化
$ terraform init
$ terraform init -backend-config="key=ncchd-dpc-${env}/terraform.tfstate"

# 2.检验 tf 文件
$ terraform validate

# 3.实施计划, 准备资源
$ terraform plan
$ terraform plan -var-file 00-env-dev.tfvars

# 4.应用部署
$ terraform apply
$ terraform apply -auto-approve
$ terraform apply -var-file 00-env-dev.tfvars -auto-approve 

# 5.摧毁系统
#$ terraform destroy#環境が削除されるので、ご注意
#$ terraform destroy -auto-approve#環境が削除されるので、ご注意
#$ terraform destroy -var-file 00-env-dev.tfvars -auto-approve#環境が削除されるので、ご注意