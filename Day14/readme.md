⭐ Project Title:
Zero-Downtime Deployments on Kubernetes: Blue-Green + Canary using Argo Rollouts 

1. 2 Versions of application .
2. Kubernetes manifests for standard deployment + Service
3. Argocd manifests for canary style gradual traffic shifting.

Blue-Green deloyment - two seperate versions [ blue = stable , green = new ]
Traffic is switched [blue-> Green]

v1 -> "blue"
v2 -> "green"


Canary deployment - Traffic is split gradually using Argo Rollouts. e,g:
. 20% -> 40% -> 60% -> 100%
V1 is running while v2 is getting tested in prod.

Ingress.yaml - tells that 20 % of the traffic to the canary service , while main service is handling 80 % of the traffic.

service.yaml - A Service in Kubernetes creates a stable, reliable networking endpoint for your Pods.