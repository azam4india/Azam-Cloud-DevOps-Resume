pipeline {
    agent any
    stages {
        stage('Terraform Apply') {
            steps {
                sh 'terraform init'
                sh 'terraform apply -auto-approve'
            }
        }
        stage('Deploy with Helm') {
            steps {
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

