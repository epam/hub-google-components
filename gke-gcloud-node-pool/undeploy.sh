#!/bin/bash -e

echo "Checking presence of node pool $NAME for cluster $CLUSTER"
if gcloud container node-pools describe "$NAME" --zone "$ZONE" --cluster "$CLUSTER" > /dev/null; then
  if ! gcloud container node-pools delete "$NAME" --zone "$ZONE" --cluster "$CLUSTER" --quiet; then 
    cat << EOF | color w
Warning: there was an error deleteing node pool: $NAME for cluster $CLUSTER
We may just left some garbage in $PROJECT project

You may want to delete resources manually and
restart to reflect actuals in deployment state

  hub stack undeploy -c "$HUB_COMPONENT"

EOF
  fi
else
  echo "Node pool seems to be already undeployed"
fi

echo "Done!"
