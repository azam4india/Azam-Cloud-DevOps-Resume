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
                    # Set Helm path
                    HELM_PATH=/c/Users/Azam/helm/helm.exe

                    # Download Helm if not present
                    if [ ! -f "$HELM_PATH" ]; then
                        curl -fsSL https://get.helm.sh/helm-v3.14.0-windows-amd64.zip -o helm.zip
                        unzip helm.zip
                        mv w

