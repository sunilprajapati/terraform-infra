pipeline {
    agent any

    stages {
        stage('ChekOut') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/rstraining4/terraform-infra.git']]])
            }
        }
        stage('terraform init') {
            steps {
                sh ('terraform init')
            }
        }
        stage('terraform action') {
            steps {
               echo "Terraform action is --> ${action}"
                sh ('terraform ${action} --auto-approve')
            }
        }
    }
}
