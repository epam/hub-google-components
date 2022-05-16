#!/bin/bash -e

gcloud services enable "container.googleapis.com"

echo "Checking presence of cluster: $NAME"
if ! gcloud container clusters describe "$NAME" --zone "$ZONE" > /dev/null; then
  color b "Creating new GKE cluster using: gcloud-container-clusters-create.yaml"
  gcloud container clusters create "$NAME" --flags-file=gcloud-container-clusters-create.yaml
else
  echo "Cluster $NAME already exist!"
fi

echo "Fetching kubeconfig..."
gcloud container clusters get-credentials "$NAME" --zone "$ZONE"
kubectl config delete-context "$HUB_DOMAIN_NAME" > /dev/null 2>&1 || true
kubectl config rename-context "$(kubectl config current-context)" "$HUB_DOMAIN_NAME"
