#!/bin/bash
envDefault="remote"
namespace=$1
doguName=$2
env="${3:-$envDefault}"
cmName="${doguName}-config"
fileName=${doguName}_config

if [ "$env" = "local" ]; then
  fileName="${fileName}_local"
fi

kubectl create cm "${cmName}" --from-file=config.yaml="${fileName}.yaml" -n "${namespace}"
kubectl label configmap "${cmName}" app=ces -n "${namespace}"
kubectl label configmap "${cmName}" dogu.name="${doguName}" -n "${namespace}"
kubectl label configmap "${cmName}" k8s.cloudogu.com/type=dogu-config -n "${namespace}"