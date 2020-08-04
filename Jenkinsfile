pipeline {
    environment {
        registry = "ymhemant/simple-go"
        registryCredential = 'docker-hub-credential'
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
            }
        }
        stage('Cleaning up') {
            steps {
                sh "echo Done"
            }
        }
    }
}