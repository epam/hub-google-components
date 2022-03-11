#!/bin/bash

curl https://storage.googleapis.com/csm-artifacts/asm/asmcli_"$VERSION" > asmcli

chmod +x asmcli

./asmcli install \
  --project_id "$PROJECT" \
  --cluster_name "$CLUSTER" \
  --cluster_location "$ZONE" \
  --enable_all

ISTIO_REV=$(kubectl --context="$DOMAIN_NAME" get deploy -n istio-system -l app=istiod -o jsonpath=\{.items[*].metadata.labels.'istio\.io\/rev'\})

echo 
echo "Outputs:"
echo "asm_rev=$ISTIO_REV"
echo "anthos_url=https://console.cloud.google.com/anthos/services?project=$PROJECT"
echo
