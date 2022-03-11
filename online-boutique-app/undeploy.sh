#!/bin/bash

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
