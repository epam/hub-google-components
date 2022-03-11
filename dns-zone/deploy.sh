#!/bin/bash

TF_VAR_name=$(echo "$DOMAIN_NAME" | cut -d. -f1)
export TF_VAR_name

terraform init -reconfigure -force-copy \
	-backend-config="bucket=$STATE_BUCKET" \
	-backend-config="prefix=$DOMAIN_NAME/$COMPONENT_NAME"

TFPLAN=.terraform/"$DOMAIN_NAME".plan

terraform plan -out="$TFPLAN"
terraform apply "$TFPLAN"
