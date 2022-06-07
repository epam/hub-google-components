#!/bin/bash

kubectl="kubectl --context=$DOMAIN_NAME"

$kubectl delete -f resources/kubernetes-manifests/deployments
$kubectl delete -f resources/kubernetes-manifests/services
if test -z "$ISTIO_REVISION"; then
	$kubectl delete -f resources/frontend-ingress.yaml
else
	$kubectl delete -f resources/istio-manifests/allow-egress-googleapis.yaml
	$kubectl delete -f resources/istio-manifests/frontend-gateway.yaml
fi

$kubectl delete -f resources/kubernetes-manifests/namespaces

retVal=$?
if [ $retVal -ne 0 ]; then
	echo "Resources do not exist in Kubernetes. Already undeployed?"
	exit 0
fi
