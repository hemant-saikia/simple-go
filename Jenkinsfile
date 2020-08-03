pipeline {
    environment {
        registry = "ymhemant/simple-go"
        registryCredential = 'ymhemant'
        dockerImage = ''
        PATH = "/usr/local/bin:$PATH"
    }
    agent any
    stages {
        stage('Cloning our Git') {
            steps {
                git 'https://github.com/saikiahemant/simple-go'
                
            }
        }
        stage('Building our image') {
             
            steps{
                sh 'echo $PATH'
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy our image') {
            steps{
                script {
                    docker.withRegistry( '', docker-hub-credentials) {
                    dockerImage.push()
                    }
                }
            }
        }
        stage('Cleaning up') {
            steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}