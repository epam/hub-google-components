#!/bin/bash

if test -z "$HUB_KUBECONFIG"; then
  HUB_KUBECONFIG="$(dotenv get "HUB_KUBECONFIG" --default "$KUBECONFIG")"
fi
export KUBECONFIG="$HUB_KUBECONFIG"

gcloud services enable "container.googleapis.com"
gcloud container clusters create "$NAME" --flags-file=gcloud-container-clusters-create.yaml

kubectl config delete-context "$HUB_DOMAIN_NAME" || echo "Moving on!"
kubectl config rename-context "$(kubectl config current-context)" "$HUB_DOMAIN_NAME"

echo
echo "Outputs:"
echo "gcp_url=https://console.cloud.google.com/kubernetes/clusters/details/$ZONE/$NAME/details?project=$PROJECT"
echo
