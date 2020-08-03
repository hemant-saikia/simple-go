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
                sh 'docker build -t simple-go .'
            }
        }
        stage('Deploy our image') {
            steps {
                withDockerRegistry([ credentialsId: "docker-hub-credentials", url: "" ]) {
                sh 'docker push ymhemant/simple-go:latest'
            }
        }
        stage('Cleaning up') {
            steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}