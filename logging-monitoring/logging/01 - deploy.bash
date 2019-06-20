# Scenario preparation
helm install stable/wordpress --name example-monitoring --values wordpress-values.yaml
kubectl create -f wordpress-troll-job.yaml

# Create the logging namespace

kubectl create ns logging

# Deploy the EFK

kubectl apply -f es-service.yaml,fluentd-es-configmap.yaml,kibana-service.yaml
kubectl apply -f es-statefulset.yaml,fluentd-es-ds.yaml,kibana-deployment.yaml

# Check the fluentd configmap

cat fluentd-es-configmap.yaml

# Check that the EFK deployment succeeded

kubectl get pods -n logging -w

# Check the fluentd and elasticsearch logs

# Then enter Kibana

kubectl proxy

# Enter http://localhost:8001/api/v1/namespaces/logging/services/kibana-logging/proxy