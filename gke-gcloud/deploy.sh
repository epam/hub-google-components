#!/bin/bash

gcloud services enable container.googleapis.com

gcloud services enable "container.googleapis.com"

echo "Checking presence of cluster: $NAME"
if ! gcloud container clusters describe "$NAME" --zone "$ZONE" > /dev/null; then
  gcloud container clusters create "$NAME" --flags-file=gcloud-container-clusters-create.yaml
  kubectl config delete-context "$HUB_DOMAIN_NAME" > /dev/null 2>&1 || true
  kubectl config rename-context "$(kubectl config current-context)" "$HUB_DOMAIN_NAME"
else
  echo "Cluster $NAME already exist, moving on!"
fi
