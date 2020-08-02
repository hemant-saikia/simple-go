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
       
        stage ('Docker Build') {
            steps {
                echo 'Starting to build docker image'
                script {
                    def app = docker.build("ymhemant/simplego")
                }
            }
        }
        
        stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        steps{
            sshagent(credentials : ['00437793-dff8-41aa-a227-66e788ab9990']) {
                sh 'scp simple-go ubuntu@ec2-3-6-77-14.ap-south-1.compute.amazonaws.com:/home/ubuntu/asterisk/simple-go'
            }
        }
        stage('Post test'){
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
