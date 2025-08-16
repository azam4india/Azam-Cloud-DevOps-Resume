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
                        mv windows-amd64/helm.exe $HELM_PATH
                    fi

                    # Use Helm to deploy chart with values.yaml
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
