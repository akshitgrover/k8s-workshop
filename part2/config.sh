#!/bin/sh

kubectl create secret generic config-secret --from-literal=os=true --from-literal=arch=true

kubectl create configmap yaml-config --from-file=deployment.yaml

echo "
apiVersion: v1
kind: Pod
metadata:
  name: config-demo
  labels:
    app: config-demo
spec:
  containers:
  - name: config-demo
    image: docker.io/akshitgrover/gethost:v1
    env:
    - name: SHOW_OS
      valueFrom:
        secretKeyRef:
          name: config-secret
          key: os
    - name: SHOW_ARCH
      valueFrom:
        secretKeyRef:
          name: config-secret
          key: arch
    volumeMounts:
    - name: configmap-demo
      mountPath: /etc/configmap-demo/yamls
      readOnly: true
  volumes:
  - name: configmap-demo
    configMap:
      name: yaml-config
" | kubectl create -f -
