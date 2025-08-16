pipeline {
    agent any
    environment {
        KUBECONFIG = "C:/Users/Azam/.kube/config"
        HELM_PATH = "C:/Users/Azam/helm/helm.exe"
        TERRAFORM_PATH = "C:/Program Files/Terraform"
    }
    stages {
        stage('Check Terraform Version') {
            steps {
                sh """
                    export PATH=\$PATH:'${TERRAFORM_PATH}'
                    terraform version
                """
            }
        }

        stage('Terraform Apply') {
            steps {
                checkout scm
                sh """
                    export PATH=\$PATH:'${TERRAFORM_PATH}'
                    terraform init
                    terraform apply -auto-approve
                """
            }
        }

        stage('Ensure Helm Installed') {
            steps {
                sh """
                    if [ ! -f "${HELM_PATH}" ]; then
                        curl -fsSL https://get.helm.sh/helm-v3.14.0-windows-amd64.zip -o helm.zip
                        unzip helm.zip
                        mv windows-amd64/helm.exe C:/Users/Azam/helm/helm.exe
                    fi
                    ${HELM_PATH} version
                """
            }
        }

        stage('Deploy Helm Chart') {
            steps {
                sh """
                    export KUBECONFIG=${KUBECONFIG}
                    ${HELM_PATH} upgrade --install resume ./helm-chart -f ./helm-chart/values.yaml
                """
            }
        }

        stage('Show Access URL') {
            steps {
                sh """
                    export KUBECONFIG=${KUBECONFIG}
                    url=$(minikube service resume --url)
                    echo "Resume available at: \$url"
                """
            }
        }
    }
}

