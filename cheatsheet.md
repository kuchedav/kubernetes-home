# Kubernetes cheat sheet

## shortcuts:
```bash
alias python="python3"
alias k="kubectl"
alias kg='kubectl get'
alias kd='kubectl describe'
alias kdel='kubectl delete'
alias ke='kubectl exec --it'
```

## apply file: 
```bash
kubectl apply -f mongo.yaml
```
## show status:
```bash
kubectl get all
kubectl get pod
```
## additional information:
```bash
kubectl get pod -o wide
kubectl get pod <pod_name> --output=yaml
```
## scale deployment
```bash
kubectl scale deployment jupyter --replicas=0
```
## deployments
```bash
describe deployment jupyter
```
## check port in container
```bash
apt-get install lsof
lsof -i -P -n
```
## Persistant volumne
```bash
kg pv
kg pvc
```
## Create Persistant volumne
```bash
https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/
minikube ssh
-> create your folder path
```
## minikube
Set minikube hardware configuration
```bash
$ minikube config set cpus N
$ minikube config set memory N
```
## Name spaces
Create namespace
```bash
kubectl create -f namespace_creation.json
```
change namespace
```bash
kubectl config set-context --current --namespace=my-namespace
```