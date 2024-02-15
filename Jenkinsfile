
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], userRemoteConfigs: [[url: 'https://github.com/hamidhosseini31397/lab2024jenkins.git']]])
            }
        }
        
         stage('Build') {
            steps {
                sh "mvn compile"
            }
        }
        
        stage('Test') {
            steps {
                sh "mvn test"
            }

            post {
                always {
                    junit '**/TEST*.xml'
                }
            }
        }
        // Other stages in your pipeline
    }
}
