#!/bin/bash

gcloud container hub memberships unregister "$CLUSTER" \
    --gke-cluster="$ZONE"/"$CLUSTER" --quiet 

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "Can't unregister cluster $CLUSTER. Trying hard delete the membership"
    gcloud container hub memberships delete "$CLUSTER" --quiet
fi
