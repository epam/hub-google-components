#!/bin/bash

gcloud services enable container.googleapis.com

gcloud container clusters create "$NAME" --flags-file=gcloud-container-clusters-create.yaml

gcloud container clusters get-credentials "$NAME" --zone "$ZONE"
# rename context to follow convention of the hub
kubectl config delete-context "$DOMAIN_NAME"
kubectl config rename-context gke_"$PROJECT"_"$ZONE"_"$NAME" "$DOMAIN_NAME"

echo 
echo "Outputs:"
echo "gcp_url=https://console.cloud.google.com/kubernetes/clusters/details/$ZONE/$NAME/details?project=$PROJECT"
echo
