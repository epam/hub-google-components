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

gcloud container clusters get-credentials "$CLUSTER" --zone "$GOOGLE_ZONE"
kubectl config delete-context "$HUB_DOMAIN_NAME" > /dev/null 2>&1 
kubectl config rename-context "$(kubectl config current-context)" "$HUB_DOMAIN_NAME"

./asmcli install \
  --project_id "$GOOGLE_PROJECT" \
  --cluster_name "$CLUSTER" \
  --cluster_location "$GOOGLE_ZONE" \
  --enable_all

NAMESPACE="$(kubectl get namespace -l hub.gke.io/project)"
if test -z "$NAMESPACE"; then
  NAMESPACE="istio-system"
fi

ISTIO_REV=$(kubectl --context="$HUB_DOMAIN_NAME" get deploy -n istio-system -l app=istiod -o jsonpath=\{.items[*].metadata.labels.'istio\.io\/rev'\})

cat << EOF

Outputs:
  asm_rev = $ISTIO_REV

EOF
