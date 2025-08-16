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
        stage('Ensure Minikube is Running') {
            steps {
                sh '''
                    # Check if Minikube is running, otherwise start it
                    if ! minikube status | grep -q "host: Running"; then
                        echo "Minikube is not running. Starting..."
                        minikube start --driver=docker
                    else
                        echo "Minikube is already running."
                    fi

                    minikube status
                '''
            }
        }
        stage('Install Helm & Deploy') {
            steps {
                sh '''
                    HELM_PATH=/c/Users/Azam/helm/helm.exe
                    KUBECONFIG=/c/Users/Azam/.kube/config

                    if [ ! -f "$HELM_PATH" ]; then
                        curl -fsSL https://get.helm.sh/helm-v3.14.0-windows-amd64.zip -o helm.zip
                        unzip helm.zip
                        mv windows-amd64/helm.exe $HELM_PATH
                    fi

                    MINIKUBE_IP=$(minikube ip)
                    echo "Minikube IP: $MINIKUBE_IP"
        
                    export KUBECONFIG=/c/Users/Azam/.kube/config
                    
                    # Use Minikube context instead of docker-desktop
                    kubectl config use-context minikube

                    "$HELM_PATH" upgrade --install resume ./helm-chart -f ./helm-chart/values.yaml
                '''
            }
        }
        stage('Show Access URL') {
            steps {
                sh '''
                    url=$(minikube service resume --url)
                    echo "Resume available at: $url"
                '''
            }
        }
    }
}
