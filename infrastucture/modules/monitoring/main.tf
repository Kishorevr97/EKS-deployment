provider "kubernetes" {
  host                   = var.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(var.eks_cluster_certificate_authority)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_id]
  }
}

provider "helm" {
  kubernetes {
    host                   = var.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(var.eks_cluster_certificate_authority)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_id]
    }
  }
}

# Create Namespace for Monitoring
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}


##newly added
resource "helm_release" "prometheus" {
 
  name       = "prometheus"
 
  repository = "https://prometheus-community.github.io/helm-charts"
 
  chart      = "kube-prometheus-stack"
 
  namespace  = "monitoring"
 
  create_namespace = true
 
  set {
 
    name  = "server.global.scrape_interval"
 
    value = "15s"
 
  }
 
  set {
 
    name  = "prometheus.service.type"
 
    value = "LoadBalancer"
 
  }
 
  timeout = 1200  # Increase timeout to 20 minutes
 
 
  set {
 
    name  = "prometheus.prometheusSpec.logLevel"
 
    value = "info"
 
  }
 
  set {
 
    name  = "prometheus.prometheusSpec.logFormat"
 
    value = "json"
 
  }
 
 
  set {
 
    name  = "prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues"
 
    value = "false"
 
  }
 
  set {
 
    name  = "prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues"
 
    value = "false"
 
  }
 
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = "monitoring"

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "adminPassword"
    value = "admin"
  }
}
