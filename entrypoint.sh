#!/bin/sh

set -e

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$KUBE_CONFIG_DATA" | base64 --decode > /tmp/config
export KUBECONFIG=/tmp/config

kubectl get pods -n $NAMESPACE | grep $POD | cut -d " " -f1 | head -1 | xargs kubectl delete pod -n $NAMESPACE
