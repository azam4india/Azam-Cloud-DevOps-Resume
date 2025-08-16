pipeline {
    agent any
    stages {
        stage('Check Terraform Version') {
            steps {
                sh '''
                    export PATH=$PATH:/c/Program\\ Files/Terraform
                    terraform version
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                checkout scm
                sh '''
                    export PATH=$PATH:/c/Program\\ Files/Terraform
                    terraform init
                    terraform apply -auto-approve
                '''
            }
        }

        stage('Install Helm & Deploy') {
            steps {
                sh '''
                    HELM_PATH=/c/Users/Azam/helm/helm.exe
                    KUBECONFIG=/c/Users/Azam/.kube/config

                    # Install helm if not already present
                    if [ ! -f "$HELM_PATH" ]; then
                        curl -fsSL https://get.helm.sh/helm-v3.14.0-windows-amd64.zip -o helm.zip
                        unzip helm.zip
                        mv windows-amd64/helm.exe $HELM_PATH
                    fi

                    # Force kube context to Docker Desktop
                    export KUBECONFIG=/c/Users/Azam/.kube/config
                    kubectl config use-context docker-desktop || { echo "Docker Desktop context not found"; exit 1; }

                    # Verify cluster connectivity
                    kubectl cluster-info || { echo "Kubernetes cluster not reachable"; exit 1; }

                    # Deploy chart
                    "$HELM_PATH" upgrade --install resume ./helm-chart -f ./helm-chart/values.yaml
                '''
            }
        }

        stage('Show Access URL') {
            steps {
                sh '''
                    export KUBECONFIG=/c/Users/Azam/.kube/config
                    kubectl config use-context docker-desktop || { echo "Docker Desktop context not found"; exit 1; }

                    # Verify cluster connectivity
                    kubectl cluster-info || { echo "Kubernetes cluster not reachable"; exit 1; }
                    
                    echo "Fetching service URL..."
                    kubectl get svc resume -o wide || echo "Service 'resume' not found"
                '''
            }
        }
    }
}

