#!/bin/sh

set -e

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$KUBE_CONFIG_DATA" | base64 -d > /tmp/config
export KUBECONFIG=/tmp/config
RN=$(kubectl describe deployment $POD -n $NAMESPACE | grep ReplicaSet | grep -v "NewReplicaSetAvailable\|OldReplicaSets\|ScalingReplicaSet" | awk -F"ReplicaSet" '{print $2}' | sed 's#:##g' | sed 's#"##g' | awk '{print $1}')
echo ReplicaSet $RN
PODS=$(for i in $(kubectl get pod -n $NAMESPACE| grep ${RN}|awk '{print $1}'); do echo $i; done)
echo Pods $PODS
kubectl delete pod ${PODS} -n $NAMESPACE
#kubectl get pods -n $NAMESPACE | grep $POD | cut -d " " -f1 | head -1 | xargs kubectl delete pod -n $NAMESPACE
