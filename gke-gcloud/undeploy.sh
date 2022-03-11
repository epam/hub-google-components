#!/bin/bash

gcloud container clusters delete "$NAME" --zone "$ZONE" --quiet

kubectl config delete-context "$DOMAIN_NAME"

retVal=$?
if [ $retVal -ne 0 ]; then
    exit 0
fi
