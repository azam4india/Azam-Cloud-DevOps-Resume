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
                    if ! command -v helm &> /dev/null; then
                        curl -fsSL https://get.helm.sh/helm-v3.14.0-linux-amd64.tar.gz -o helm.tar.gz
                        tar -zxvf helm.tar.gz
                        mv linux-amd64/helm ./
                    fi

                    ./helm upgrade --install resume ./helm-chart -f ./helm-chart/values.yaml
                       
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




