#!/bin/bash

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

