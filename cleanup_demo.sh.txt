#!/bin/bash
set -e

echo "=== Cleaning up Resume Demo ==="

echo "Uninstalling Helm release..."
helm uninstall resume || true

echo "Destroying Terraform infra..."
terraform destroy -auto-approve || true

echo "Stopping Minikube..."
minikube delete || true

echo "=== Cleanup Complete ==="


