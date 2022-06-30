#!/bin/bash -e

if ! gcloud container hub memberships unregister "$CLUSTER" --gke-cluster="$GOOGLE_ZONE/$CLUSTER" --project="$GOOGLE_PROJECT" --quiet; then
  color warning "Can't unregister cluster $CLUSTER. Trying hard delete the membership"
  if ! gcloud container hub memberships delete "$CLUSTER" --quiet; then
    cat << EOF | color warn
Warning: encountered error while deleting hub memership for $CLUSTER
We may just left some garbage in $GOOGLE_PROJECT project
EOF
  fi
fi
