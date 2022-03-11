#!/bin/bash

kubectl delete --context="$DOMAIN_NAME" -n "$INGRESS_NAMESPACE" -f resources/

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Resources do not exist in Kubernetes. Already undeployed?"
    exit 0
fi
