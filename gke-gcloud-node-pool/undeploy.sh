#!/bin/bash

gcloud container node-pools delete "$NAME" \
 --zone "$ZONE" \
 --cluster "$CLUSTER" --quiet

retVal=$?
if [ $retVal -ne 0 ]; then
    exit 0
fi
