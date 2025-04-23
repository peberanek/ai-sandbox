# Kubernetes

For installation steps, requirements, SSO config and more see: https://github.com/open-webui/helm-charts/blob/main/charts/open-webui/README.md

Once all pods are ready proceed with the port forwarding (taken from [Access via ClusterIP service](https://github.com/open-webui/helm-charts/blob/main/charts/open-webui/templates/NOTES.txt)):

```sh
export LOCAL_PORT=8080
export POD_NAME=$(kubectl get pods -n default -l "app.kubernetes.io/component=open-webui" -o jsonpath="{.items[0].metadata.name}")
export CONTAINER_PORT=$(kubectl get pod -n default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
kubectl -n default port-forward $POD_NAME $LOCAL_PORT:$CONTAINER_PORT
echo "Visit http://127.0.0.1:$LOCAL_PORT to use your application"
```
