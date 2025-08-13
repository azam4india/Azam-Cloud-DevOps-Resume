#!/bin/bash
set -e

echo "=== Starting Resume Demo ==="

# Ensure Minikube is running
if ! minikube status >/dev/null 2>&1; then
    echo "Starting Minikube..."
    minikube start
fi

# Run Jenkins pipeline locally or via CLI
echo "Triggering Jenkins pipeline..."
jenkins-cli build resume-demo -s

echo "=== Demo started. Check Jenkins console for progress. ==="

