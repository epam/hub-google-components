#!/bin/bash
# shellcheck disable=SC2154

echo "Pipele 2"

terraform init -reconfigure -force-copy \
		-backend-config="bucket=$STATE_BUCKET" \
		-backend-config="prefix=$DOMAIN_NAME/$COMPONENT_NAME"

TFPLAN=.terraform/"$DOMAIN_NAME".plan

terraform plan -out="$TFPLAN"
terraform apply "$TFPLAN"


gcloud container clusters get-credentials "$TF_VAR_name" --zone "$TF_VAR_location"

# rename context to follow convention of the hub
kubectl config rename-context gke_"$TF_VAR_project"_"$TF_VAR_location"_"$TF_VAR_name" "$DOMAIN_NAME"
