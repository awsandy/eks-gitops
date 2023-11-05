resource "kubernetes_namespace_v1" "aws_load_balancer_controller" {
  metadata {
    annotations = {
      name = "aws-lb-controller"
    }

    labels = {
      mylabel = "aws-lb-controller"
    }

    name = "aws-lb-controller"
  }
}


resource "kubernetes_namespace_v1" "metrics" {
  metadata {
    annotations = {
      name = "metrics"
    }

    labels = {
      mylabel = "metrics"
    }

    name = "metrics"
  }
}

resource "kubernetes_namespace_v1" "cw-metrics" {
  metadata {
    annotations = {
      name = "cw-metrics"
    }

    labels = {
      mylabel = "cw-metrics"
    }

    name = "cw-metrics"
  }
}

resource "kubernetes_namespace_v1" "fluentbit-nodes" {
  metadata {
    annotations = {
      name = "fluentbit-nodes"
    }

    labels = {
      mylabel = "fluentbit-nodes"
    }

    name = "fluentbit-nodes"
  }
}





