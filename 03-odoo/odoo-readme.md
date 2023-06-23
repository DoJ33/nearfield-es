# Refers

## Bitnami
>
> 1. <https://github.com/bitnami/charts/tree/main/bitnami/odoo>
> 2. <https://docs.bitnami.com/kubernetes/get-started-kubernetes/>
> 3. <https://docs.bitnami.com/tutorials/production-ready-charts/>
> 4. <https://docs.bitnami.com/tutorials/secure-wordpress-kubernetes-managed-database-ssl-upgrades>

## Odoo In MicroK8s
>
> 1. <https://www.idaz.co/posts/odoo-in-kubernetes/>

# Odoo installation

```bash
helm install odoo bitnami/odoo -f odoo-values.yaml -n postgres-operator
```

**Please be patient while the chart is being deployed**

1. Get the Odoo URL by running:

**Please ensure an external IP is associated to the odoo service before proceeding**
**Watch the status using: kubectl get svc --namespace postgres-operator -w odoo**

```bash
  export SERVICE_IP=$(kubectl get svc --namespace postgres-operator odoo --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
  echo "Odoo URL: http://$SERVICE_IP/"
```

> Odoo URL: <http://192.168.100.241/>

2. Obtain the login credentials

```bash
  export ODOO_EMAIL=<user@example.com>
  export ODOO_PASSWORD=$(kubectl get secret --namespace "postgres-operator" odoo -o jsonpath="{.data.odoo-password}" | base64 -d)

  echo Email   : $ODOO_EMAIL
  echo Password: $ODOO_PASSWORD
```

>Email : <user@example.com>
> Password: JQHHdHj3Fu
