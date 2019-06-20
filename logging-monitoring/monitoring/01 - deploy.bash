# Deploy Prometheus

helm install stable/prometheus --name=prometheus --namespace=monitoring

# Verify

kubectl get pod --namespace=monitoring
kubectl get svc --namespace=monitoring

# Access Prometheus
kubectl --namespace monitoring port-forward svc/prometheus-server 9090:80 &

# Access http://127.0.0.1:9090

# Let's deploy WordPress with a exporter

helm upgrade example-monitoring stable/wordpress -f wordpress-exporter-values.yaml

# Then let's deploy a WordPress job that pushes metrics to PushGateway

kubectl apply -f yaml-spoiler/02-mysql-backup-job.yaml

# Finally let's update prometheus to include alert manager rules

helm upgrade prometheus stable/prometheus --namespace monitoring -f prometheus-alertmanager.yaml

# Now let's deploy Grafana

helm install stable/grafana --name=grafana --namespace=monitoring
grafana_secret=$(kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo)
kubectl --namespace monitoring port-forward svc/grafana 3000:80 &
echo ${grafana_secret:?}

# Visit http://localhost:3000