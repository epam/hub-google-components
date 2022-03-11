#!/bin/bash

terraform init -reconfigure -force-copy \
	-backend-config="bucket=$STATE_BUCKET" \
	-backend-config="prefix=$DOMAIN_NAME/$COMPONENT_NAME"

TFPLAN=.terraform/"$DOMAIN_NAME".plan

terraform plan -destroy -out="$TFPLAN"
terraform apply "$TFPLAN"
