#!/bin/bash

gcloud container node-pools describe "$NAME" \
 --zone "$ZONE" \
 --cluster "$CLUSTER"

retVal=$?
if [ $retVal -eq 0 ]; then
    echo "Node pool $NAME already exists"
    exit 0
fi

gcloud container node-pools create "$NAME" \
 --flags-file=gcloud-container-node-pools-create.yaml

