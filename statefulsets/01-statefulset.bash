#!/bin/bash

# Deploy a Cassandra statefulset

kubectl create -f yaml/01-cassandra.yaml

# See how it gets deployed in order

kubectl get pods -w

# Anything missing? They cannot access each other

kubectl create -f yaml/02-headless-service.yaml

# Check the PVCs

kubectl get pvc 

# Delete the statefulset 

kubectl delete -f yaml/
