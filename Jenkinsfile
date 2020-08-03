pipeline {
    environment {
        registry = "ymhemant/simple-go"
        registryCredential = 'ymhemant'
        dockerImage = ''
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
                sh 'docker build -t simple-go .'
            }
        }
        stage('Deploy our image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
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