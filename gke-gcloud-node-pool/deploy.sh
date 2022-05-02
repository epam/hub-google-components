#!/bin/bash -e

echo "Checking presence of node pool $NAME for cluster $CLUSTER"
if gcloud container node-pools describe "$NAME" --zone "$ZONE" --cluster "$CLUSTER" > /dev/null; then
  echo "Already exists"
else
  color b "Creating new node pool for cluster $CLUSTER using: gcloud-container-node-pools-create.yaml..."
  gcloud container node-pools create "$NAME" --flags-file=gcloud-container-node-pools-create.yaml
fi

echo "Done!"
