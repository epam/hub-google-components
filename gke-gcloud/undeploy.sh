#!/bin/bash -e

echo "Checking presence of cluster: $NAME"
if gcloud container clusters describe "$NAME" --zone "$ZONE" > /dev/null; then
  if gcloud container clusters delete "$NAME" --zone "$ZONE" --quiet; then
    kubectl config delete-context "$DOMAIN_NAME" || true
  else
    cat << EOF | color w
Warning: there was an error deleteing cluster: $NAME
We may just left some garbage in $PROJECT project

You may want to delete resources manually and
restart to reflect actuals in deployment state

  hub stack undeploy -c "$HUB_COMPONENT"

EOF
  fi
else
  echo "Cluster $NAME seems to be already deleted"
fi
