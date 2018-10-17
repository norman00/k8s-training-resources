#
# Kubeapps installation
#

KUBEAPPS_DOMAIN="kubeapps.custom.domain"

################
# Previous Steps
################
# Helm installation
## It's neccessary to create a serviceAccount/ClusterRoleBinding to allow
## Tiller to deploy charts on the cluster
kubectl apply -f helm-service-account.yaml
kubectl apply -f helm-cluter-role-binding.yaml
## Then, init helm with the corresponding serviceAccount
helm init --service-account helm

#######################
# Kubeapps Installation
#######################
helm install --name kubeapps --namespace kubeapps bitnami/kubeapps \
  --set ingress.enabled=true \
  --set ingress.hosts[0].name=$KUBEAPPS_DOMAIN \
  --set ingress.hosts[0].tls=true \
  --set ingress.hosts[0].tlsSecret=kubeapps-tls \
  --set ingress.hosts[0].certManager=true
## Create serviceAccount for user 'example' and obtain token
TARGET_NAMESPACE='default'
kubectl create --namespace $TARGET_NAMESPACE serviceaccount example
kubectl get --namespace $TARGET_NAMESPACE secret $(kubectl get -n default serviceaccount example -o jsonpath='{.secrets[].name}') -o jsonpath='{.data.token}' | base64 --decode

## Browse to Kubeapps Dashboard and try to deploy Dokuwiki chart
## What's hapenning?

## Let's create a rolebinding with edit role on 'default' namespace for 'example' serviceAccount
## We'll also need a rolebinding with read permissions on 'kubeapps' namespace for 'example' serviceAccount
kubectl create --namespace $TARGET_NAMESPACE rolebinding example-edit \
  --clusterrole=edit \
  --serviceaccount default:example

## Browse to Kubeapps Dashboard and try to deploy Dokuwiki chart again
## What's hapenning?

## We'll also need a rolebinding with read permissions on 'kubeapps' namespace for 'example' serviceAccount
kubectl apply --namespace kubeapps -f https://raw.githubusercontent.com/kubeapps/kubeapps/master/docs/user/manifests/kubeapps-repositories-read.yaml
kubectl create --namespace kubeapps rolebinding example-kubeapps-repositories-read \
  --role=kubeapps-repositories-read \
  --serviceaccount default:example

## Browse to Kubeapps Dashboard and try to deploy Dokuwiki chart again
