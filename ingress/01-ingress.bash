#!/bin/bash

# Let's create a new namespace for the solution

kubectl create ns ingress-example

# Let's deploy a WordPress solution

kubectl create -n ingress-example -f wordpress-yaml/

# Let's wait for the pods to be ready

kubectl get pods -n ingress-example -w

# Add a host entry for testing

sudo nano /etc/hosts

# Modify yaml/ingress.yaml with the domain you want 

# Then let's deploy the ingress rule

kubectl create -n ingress-example -f yaml/ingress.yaml

# Once done, let's delete the workspace

kubectl delete ns ingress-example
