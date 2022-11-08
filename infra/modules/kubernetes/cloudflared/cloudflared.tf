resource "kubectl_manifest" "namespace" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: cloudflared
YAML
  apply_only = true
}

resource "kubectl_manifest" "config" {
  yaml_body = <<YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: cloudflared
  namespace: cloudflared
data:
  config.yaml: |
    # Name of the tunnel you want to run
    tunnel: ${var.tunnel_name}

    credentials-file: /etc/cloudflared/creds/credentials.json

    # Serves the metrics server under /metrics and the readiness server under /ready
    metrics: 0.0.0.0:2000

    # Disabled for Kubernetes
    no-autoupdate: true

    # This rule matches all inbound traffic, and routes it to the ingress controller
    ingress:
      - hostname: "*.${var.zone_name}"
        service: https://ingress-nginx-controller.ingress-nginx
        # TODO: Remove this for prod (requires cert-manager)
        originRequest:
          noTLSVerify: true
      - service: http_status:404
YAML
  depends_on = [ kubectl_manifest.namespace ]
  apply_only = true
}

resource "kubectl_manifest" "credentials" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: tunnel-credentials
  namespace: cloudflared
type: Opaque
stringData:
  credentials.json: |
    {
      "AccountTag"   : "${var.account_id}",
      "TunnelID"     : "${var.tunnel_id}",
      "TunnelName"   : "${var.tunnel_name}",
      "TunnelSecret" : "${var.tunnel_secret}"
    }
YAML
  depends_on = [ kubectl_manifest.namespace ]
  apply_only = true
}
