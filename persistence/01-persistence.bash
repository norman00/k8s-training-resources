#!/bin/bash

# Let's create a new namespace for the solution

kubectl create ns volume-example

# Let's deploy part of the WordPress solution

kubectl create -n volume-example -f 00-yamls/

# Let's deploy the wordpress and mariadb volume examples

kubectl create -n volume-example -f 01-Volumes/

# Let's wait for the pods to be ready

kubectl get pods -n volume-example -w

# Enter your node and check if the hostpath folders are created, did something happen?

# Delete the deployments and create one with PVCs

kubectl delete -n volume-example -f 01-Volumes/

kubectl create -n volume-example -f 02-PVCs/

# Check the PVs and PVC created

kubectl get pv 

kubectl get pvc -n volume-example

# Remove everything

kubectl delete ns volume-example
