#!/bin/bash -e

if ! gcloud container hub memberships unregister "$CLUSTER" --gke-cluster="$ZONE/$CLUSTER" --quiet; then
  echo "Can't unregister cluster $CLUSTER. Trying hard delete the membership"
  if ! gcloud container hub memberships delete "$CLUSTER" --quiet; then
    cat << EOF | color warn
Warning: delete hub memership for $CLUSTER
We may just left some garbage in $PROJECT project
EOF
  fi
fi
