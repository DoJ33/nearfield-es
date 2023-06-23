# install traefik

1.install traefik

```bash
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
helm install traefik traefik/traefik - namespace postgres-operator
```

2.Validate the installation

```bash
kubectl get all -n postgres-operator
```

3.Get the external ip address

```bash
kubectl get svc -n postgres-operator
```

## Troubleshooting

- External IP is pending (<https://makeoptim.com/service-mesh/kubernetes-external-ip-pending/>)
  - at local machine, run `microk8s enable metallb` to config the external ip address
  - see the details at `06-MetaiLB/metallb-readme.md`

# Config certificates with mkcert for traefik

1.Install mkcert on ubuntu 22.04

```bash
# https://github.com/FiloSottile/mkcert

# install mkcert
sudo apt install libnss3-tools

curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
chmod +x mkcert-v*-linux-amd64
sudo cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert
```

2.Create a local CA

```bash
mkcert -install

mkcert mk8s.localhost "*.mk8s.localhost" odoo.local kk.local es.local "*.domain.local" localhost 1
27.0.0.1 ::1

Created a new certificate valid for the following names 📜
 - "mk8s.localhost"
 - "*.mk8s.localhost"
 - "odoo.local"
 - "kk.local"
 - "es.local"
 - "*.domain.local"
 - "localhost"
 - "127.0.0.1"
 - "::1"

Reminder: X.509 wildcards only go one level deep, so this won't match a.b.mk8s.localhost ℹ️

The certificate is at "./mk8s.localhost+8.pem" and the key at "./mk8s.localhost+8-key.pem" ✅

It will expire on 21 September 2025 🗓
```

# First look on to Traefik Dashboard

```bash
helm show values traefik/traefik > traefik-values.yaml
```

```bash
kubectl port-forward -n postgres-operator  --address localhost,192.168.100.240 pod/traefik-65554ccb56-s5zhx 9000:9000
# Forwarding from 127.0.0.1:9000 -> 9000
# Forwarding from [::1]:9000 -> 9000
# Unable to listen on port 9000: Listeners failed to create with the following errors: [unable to create listener: Error listen tcp4 192.168.100.240:9000: bind: cannot assign requested address]
# error: unable to listen on any of the requested ports: [{9000 9000}]
```

## Explore dashboard with https

<https://www.padok.fr/en/blog/traefik-kubernetes-certmanager>

============================

# Refers

## video

**Traefik v2 in Kubernetes**

- <https://www.youtube.com/playlist?list=PL34sAs7_26wNldKrBBY_uagluNKC9cCak>

## Docs

**Install Traefik with Network Load Balancer**

- <https://hackmd.io/@sagar-skywalker/traefik-nlb?utm_source=preview-mode&utm_medium=rec>

**Traefik & Kubernetes**

- <https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/>

**How to Use Traefik as Ingress Router on AWS**

- <https://enginaltay.medium.com/how-to-use-traefik-as-ingress-router-on-aws-fc559f87f4d8>

## Github

- <https://github.com/johanbook/microk8s-example-stack>
`This is a PoC for a microk8s stack using both Traefik's IngressRoute and NGINX as ingress controllers. Traefik's forwardAuth middleware is used to emulate global authentication (although a static response is returned, see services/auth-server).`

- <https://github.com/FiloSottile/mkcert>
`making locally-trusted development certificates. It requires no configuration`

- <https://github.com/thomseddon/traefik-forward-auth>
`Minimal forward authentication service that provides Google/OpenID oauth based login and authentication for the traefik reverse proxy`
