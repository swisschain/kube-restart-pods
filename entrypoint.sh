#!/bin/sh

set -e

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$KUBE_CONFIG_DATA" | base64 --decode > /tmp/config
export KUBECONFIG=/tmp/config

kubectl get pods  -n $NAMESPACE --no-headers=true | awk '/$POD-/{print $1}' | xargs  kubectl delete -n $NAMESPACE pod
