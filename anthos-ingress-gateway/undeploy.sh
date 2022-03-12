#!/bin/bash

gcloud container clusters get-credentials "$NAME" --zone "$ZONE"
kubectl config delete-context "$DOMAIN_NAME" > /dev/null 2>&1 
kubectl config rename-context gke_"$PROJECT"_"$ZONE"_"$NAME" "$DOMAIN_NAME"

kubectl delete --context="$DOMAIN_NAME" -n "$INGRESS_NAMESPACE" -f resources/

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Resources do not exist in Kubernetes. Already undeployed?"
    exit 0
fi
