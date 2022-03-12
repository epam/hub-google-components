#!/bin/bash

gcloud container clusters get-credentials "$NAME" --zone "$ZONE"
kubectl config delete-context "$DOMAIN_NAME" 
kubectl config rename-context gke_"$PROJECT"_"$ZONE"_"$NAME" "$DOMAIN_NAME"

kubectl="kubectl --context=$DOMAIN_NAME"

$kubectl create namespace "$INGRESS_NAMESPACE"
$kubectl label namespace "$INGRESS_NAMESPACE" istio.io/rev="$ISTIO_REVISION" --overwrite

$kubectl apply -n "$INGRESS_NAMESPACE" -f resources/

echo "Waiting while load balancer for Ingress Gateway is created..."
while [ -z "$CLUSTER_IP" ]; do
    sleep 2
    CLUSTER_IP=$($kubectl get svc istio-"$GATEWAY_NAME" -n "$INGRESS_NAMESPACE" -ojsonpath='{.status.loadBalancer.ingress[0].ip}')
done
echo "Done. IP of the Ingress Gateway load balancer is $CLUSTER_IP"

echo 
echo "Outputs:"
echo "ingress_gateway_ip=$CLUSTER_IP"
echo

