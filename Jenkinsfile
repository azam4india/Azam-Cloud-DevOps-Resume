pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:1.5.0'   // Linux container with Terraform
            args '-v /var/run/docker.sock:/var/run/docker.sock' // If you need Docker inside
        }
    }
    stages {
        stage('Terraform Apply') {
            steps {
                sh 'terraform init'
                sh 'terraform apply -auto-approve'
            }
        }
        stage('Deploy with Helm') {
            steps {
                // Install helm if not in base image
                sh 'apk add --no-cache curl bash tar && curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash'
                sh 'helm upgrade --install resume ./helm-chart --set config.indexHtml="$(cat index.html)"'
            }
        }
        stage('Show Access URL') {
            steps {
                script {
                    def url = sh(returnStdout: true, script: "minikube service resume --url").trim()
                    echo "Resume available at: ${url}"
                }
            }
        }
    }
}
