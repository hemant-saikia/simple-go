pipeline {
    environment {
        registry = "ymhemant/simple-go"
        registryCredential = 'docker-hub-credentials'
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
        stage('Test') {
            steps {
                sh 'echo $PATH'
            }
        }
       stage('Building image') {
            steps{
                script {
                dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy Image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                    }
                }
                sh 'echo Who knows?'
            }
        }
        stage('Cleaning up') {
            steps {
                sh "echo Done"
            }
        }
    }
}