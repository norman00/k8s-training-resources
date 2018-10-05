# Deploy nginx 

kubectl create ns init-cont-example

kubectl create -n init-cont-example -f yaml/

# Check the init containers with kubectl describe

# Delete the namespace

kubectl delete ns init-cont-example
