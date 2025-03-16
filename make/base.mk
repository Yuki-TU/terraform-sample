.DEFAULT_GOAL := plan

ENV                  ?= local# stg, prd
CREDENTIAL_FILE_NAME ?= encrypted_secret
VAR_FILE              = ./tfvars/${ENV}.tfvars
VAR_OPTS              = -var-file "$(VAR_FILE)"
BACKEND_FILE          = ./tfbackend/${ENV}.s3.tfbackend
BACKEND_OPTS          = -backend-config="$(BACKEND_FILE)"
AWS_PROFILE           = nerusan-${ENV}
AWS_DEFAULT_REGION   ?= ap-northeast-1
AWS_ENDPOINT          = http://localhost:5001
AWS_ENDPOINT_OPTS     = --endpoint-url="${AWS_ENDPOINT}"

.PHONY: clean
clean:
	rm -rf .terraform

.PHONY: fmt
fmt:
	terraform fmt

.PHONY: init
init:
	@AWS_PROFILE=$(AWS_PROFILE) AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) terraform init -reconfigure $(BACKEND_OPTS)

.PHONY: plan
plan: init
	@AWS_PROFILE=$(AWS_PROFILE) AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) terraform plan $(VAR_OPTS) -lock=false -refresh=true

.PHONY: apply
apply: init
	@AWS_PROFILE=$(AWS_PROFILE) AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) terraform apply $(VAR_OPTS) -lock=false -refresh=true


.PHONY: list
list: init
	@AWS_PROFILE=$(AWS_PROFILE) AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) terraform state list


.PHONY: show
show:
	@AWS_PROFILE=$(AWS_PROFILE) AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) terraform show


.PHONY: bucket
bucket: ## バックエンド用のS3バケットを作成
	@AWS_PROFILE=$(AWS_PROFILE) aws ${AWS_ENDPOINT_OPTS} s3 mb s3://point-app-tfstate-${ENV}
