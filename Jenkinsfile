pipeline {
    agent any
    tools {
        go 'Go1.14'
    }
    environment {
        GO114MODULE = 'on'
        CGO_ENABLED = 0 
        GOPATH = "${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}"
        BINARYPATH = "${JENKINS_HOME}/workspace/${JOB_NAME}"
    }
    stages {        
        stage('Pre Test') {
            steps {
                echo 'Installing dependencies'
                sh 'go version'
                sh 'go get -d ./'
            }
        }
        
        stage('Build') {
            steps {
                echo "${GOPATH}"
                echo 'Compiling and building'
                sh 'env GOOS=linux go build'
            }
        }

        stage('Test') {
            steps {
                withEnv(["PATH+GO=${GOPATH}/bin"]){
                    echo 'Running vetting'
                    sh 'go vet .'
                    echo 'Running test'
                    sh 'go test -v'
                }
            }
        }
       
        stage ('Deploy') {
            steps{
                    
                    sh 'docker build -t simple-go .'
                    sh 'docker run -d -p 8888:8888 simple-go'
                
            }
        }
        stage('Done'){
            steps{
                echo 'Done with builds and tests'
            }	
        }
    }
    post{
    success {
      slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})  BUILD_LOG_EXCERPT")
    }
    failure {
      slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }
}
}
