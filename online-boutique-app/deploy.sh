#!/bin/bash

kubectl="kubectl --context=$DOMAIN_NAME"

$kubectl apply -f resources/kubernetes-manifests/namespaces
$kubectl apply -f resources/kubernetes-manifests/deployments
$kubectl apply -f resources/kubernetes-manifests/services

if test -z "$ISTIO_REVISION"; then
  $kubectl apply -f resources/frontend-ingress.yaml
else
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
fi
