pipeline {
    environment {
        registry = "ymhemant/asterisk"
        PATH = "/usr/local/bin:$PATH"
    }
    agent any
    stages {
        stage('Cloning our Git') {
            steps {
                git url: 'https://bitbucket.org/yellowmessenger/asterisk-ari.git',
                credentialsId: 'bitbucket-login'
            }
        }
        stage('Test') {
            steps {
                sh 'echo $PATH'
            }
        }
       stage('Building image') {
            steps{
                sh 'docker build -t asterisk .'
            }
        }
        stage ('Deploy') {
            steps{
                    sshagent(credentials : ['00437793-dff8-41aa-a227-66e788ab9990']) {
                    sh 'docker save -o image.zip asterisk'
                    sh 'scp image.zip ubuntu@ec2-3-6-77-14.ap-south-1.compute.amazonaws.com:/home/ubuntu/hemant/'
                    
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