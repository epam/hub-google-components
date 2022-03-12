#!/bin/bash

gcloud container clusters get-credentials "$NAME" --zone "$ZONE"
kubectl config delete-context "$DOMAIN_NAME" > /dev/null 2>&1 
kubectl config rename-context gke_"$PROJECT"_"$ZONE"_"$NAME" "$DOMAIN_NAME"

kubectl="kubectl --context=$DOMAIN_NAME"

$kubectl apply -f resources/kubernetes-manifests/namespaces
$kubectl apply -f resources/kubernetes-manifests/deployments
$kubectl apply -f resources/kubernetes-manifests/services
$kubectl apply -f resources/istio-manifests/allow-egress-googleapis.yaml

# Apply revision label to all namespaces
for ns in ad cart checkout currency email frontend loadgenerator \
  payment product-catalog recommendation shipping; do
    kubectl label namespace $ns istio.io/rev="$ISTIO_REVISION" --overwrite
done;

# Restart the pods
for ns in ad cart checkout currency email frontend loadgenerator \
  payment product-catalog recommendation shipping; do
    kubectl rollout restart deployment -n ${ns}
done;

# Deploy a Gateway and VirtualService for the frontend service
kubectl apply -f resources/istio-manifests/frontend-gateway.yaml
