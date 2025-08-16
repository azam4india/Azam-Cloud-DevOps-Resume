pipeline {
    agent any

    stages {
        stage('Checkout Repo') {
            steps {
                checkout scm
            }
        }

        stage('Fetch index.html from GitHub') {
            steps {
                sh '''
                    curl -o index.html https://raw.githubusercontent.com/<your-username>/<your-repo>/main/index.html
                '''
            }
        }

        stage('Update values.yaml with HTML') {
            steps {
                sh '''
                    INDEX_HTML=$(cat index.html | sed 's/"/\\"/g')
                    echo "config:" > ./helm-chart/values.yaml
                    echo "  indexHtml: |" >> ./helm-chart/values.yaml
                    echo "$INDEX_HTML" | sed 's/^/    /' >> ./helm-chart/values.yaml
                '''
            }
        }

        stage('Helm Upgrade/Install') {
            steps {
                sh '''
                    helm upgrade --install resume ./helm-chart -f ./helm-chart/values.yaml
                '''
            }
        }

        stage('Show Access URL') {
            steps {
                sh '''
                    echo "Fetching service URL..."
                    minikube service resume --url
                '''
            }
        }
    }
}
