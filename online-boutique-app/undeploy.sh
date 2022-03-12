#!/bin/bash

gcloud container clusters get-credentials "$NAME" --zone "$ZONE"
kubectl config delete-context "$DOMAIN_NAME" > /dev/null 2>&1 
kubectl config rename-context gke_"$PROJECT"_"$ZONE"_"$NAME" "$DOMAIN_NAME"

kubectl delete --context="$DOMAIN_NAME" -f resources/kubernetes-manifests/deployments
kubectl delete --context="$DOMAIN_NAME" -f resources/kubernetes-manifests/services
kubectl delete --context="$DOMAIN_NAME" -f resources/istio-manifests/allow-egress-googleapis.yaml
kubectl delete --context="$DOMAIN_NAME" -f resources/istio-manifests/frontend-gateway.yaml

kubectl delete --context="$DOMAIN_NAME" -f resources/kubernetes-manifests/namespaces

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Resources do not exist in Kubernetes. Already undeployed?"
    exit 0
fi
