#!/bin/bash

TF_VAR_domain_name=$DOMAIN_NAME
export TF_VAR_domain_name

TF_VAR_wp_salt=none
export TF_VAR_wp_salt

terraform init -reconfigure -force-copy \
	-backend-config="bucket=$STATE_BUCKET" \
	-backend-config="prefix=$DOMAIN_NAME/$COMPONENT_NAME"

TFPLAN=.terraform/"$DOMAIN_NAME".plan

terraform plan -destroy -out="$TFPLAN"
terraform apply "$TFPLAN"
