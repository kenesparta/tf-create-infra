SHELL:=/bin/bash
dev/init:
	source ../.env && \
	terraform init

dev/plan:
	source ../.env && \
	terraform plan -parallelism=15 -out aws.cluster.tfplan

dev/apply:
	source ../.env && terraform apply "aws.cluster.tfplan"

dev: dev/init dev/plan dev/apply

dev/destroy:
	source ../.env && terraform destroy
