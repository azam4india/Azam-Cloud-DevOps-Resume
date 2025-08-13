resource "null_resource" "start_minikube" {
  provisioner "local-exec" {
    command = "minikube start"
  }
}

output "kubeconfig_path" {
  value = "~/.kube/config"
}
