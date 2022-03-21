#!/bin/bash

gcloud services enable servicenetworking.googleapis.com

terraform init -reconfigure -force-copy \
	-backend-config="bucket=$STATE_BUCKET" \
	-backend-config="prefix=$DOMAIN_NAME/$COMPONENT_NAME"

TFPLAN=.terraform/"$DOMAIN_NAME".plan

terraform plan -out="$TFPLAN"
terraform apply "$TFPLAN"

echo "db_password = $(terraform output --json | jq -crM '.db_password_raw.value')"
