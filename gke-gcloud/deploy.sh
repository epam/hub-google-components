#!/bin/bash

gcloud services enable container.googleapis.com

gcloud container clusters create "$NAME" --flags-file=gcloud-container-clusters-create.yaml

echo 
echo "Outputs:"
echo "gcp_url=https://console.cloud.google.com/kubernetes/clusters/details/$ZONE/$NAME/details?project=$PROJECT"
echo
