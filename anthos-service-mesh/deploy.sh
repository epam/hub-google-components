#!/bin/bash -e

if [[ "${BASH_VERSINFO:-0}" -lt 4 ]]; then
  cat << EOF | color warn 
Warning: this component can be only installed on bash v4.0+

We cannot guarantee the correct work of anthos. To confirm successful installation please run

  kubectl get deploy -n istio-system -l app=istiod

TODO: We may consider to fail deployment at this stage! Moving on for now!

EOF
fi

curl -sLo "asmcli" "$ASMCLI_URL"
chmod +x asmcli

./asmcli install \
  --output_dir .dist \
  --project_id "$GOOGLE_PROJECT" \
  --cluster_name "$CLUSTER" \
  --cluster_location "$GOOGLE_ZONE" \
  --enable_all

ISTIO_REV=$(kubectl --context="$HUB_DOMAIN_NAME" get deploy -n istio-system -l app=istiod -o jsonpath=\{.items[*].metadata.labels.'istio\.io\/rev'\})
cat << EOF 

Outputs:
  asm_rev = $ISTIO_REV
  asm_url = https://console.cloud.google.com/anthos/services?project=$GOOGLE_PROJECT"

EOF
