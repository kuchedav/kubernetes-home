# Kubernetes Cluster

To log the output of all pods on my kubernetes cluster, I use elastic search and fluent-bit

```bash

############# ELASTICSEARCH #############

# Add the Elastic Helm charts repository
helm repo add elastic https://helm.elastic.co

# Update the Helm repository
helm repo update

# Install Elasticsearch using Helm
helm install elasticsearch elastic/elasticsearch -f kubernetes_logging/elasticsearch_values.yaml

############# FLUENT_BIT #############

# Add the Fluent Helm charts repository
helm repo add fluent https://fluent.github.io/helm-charts

# Update the Helm repository
helm repo update

# Install Fluent-Bit using Helm
helm install fluent-bit fluent/fluent-bit -f kubernetes_logging/fluent-bit_values.yaml

############# KIBANA #############

# Install Kibana using Helm
helm install kibana elastic/kibana -f kubernetes_logging/kibana_values.yaml

# Expose Kibana service
kubectl port-forward service/kibana-kibana 5601:5601

# UNINSTALL Kibana
kubectl delete role pre-install-kibana-kibana
helm uninstall kibana
kubectl delete configmap kibana-kibana-helm-scripts
kubectl delete serviceaccount pre-install-kibana-kibana
kubectl delete rolebinding pre-install-kibana-kibana
kubectl delete job pre-install-kibana-kibana
```