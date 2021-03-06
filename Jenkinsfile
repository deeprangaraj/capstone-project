pipeline {
    
    agent { label 'workers' }

    tools {
       maven "M3"
    }
 
    stages {

        stage('Checkout external proj') {
           steps {
             git branch: 'main',
                credentialsId: '701898e5-0bf4-44a6-827f-37c85a090b1f',
                url: 'https://github.com/deeprangaraj/capstone-project.git'
             sh "ls -la"
           }
        }

        stage ('maven version') {
            steps {
                sh 'mvn --version'
            }
        }

        stage('maven install') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('docker build') {

           steps {
               sh 'docker build -t deepapraj/sample-app .'
           }
        }
        
        stage('Run Container on Dev Server') {
            steps {
                sh 'docker run -p 8080:8080 -d --name sample-web-app deepapraj/sample-app'
            }
        }

        stage ('Run sample test to verify webpage is working') {
            steps {
                sh 'sleep 10'
                sh 'curl localhost:8080/SampleWebApp/welcome | grep "Deepa\'s First Sample Web Application"'
            }   
        }

        stage('Push Docker Image') {

            steps {
                withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
                   sh "docker login -u deepapraj -p ${dockerHubPwd}"
                }
                sh 'docker push deepapraj/sample-app'
            }
        }

        stage('remove container stack')
        {
            steps {
                sh 'docker kill sample-web-app' 
                sh 'docker image remove deepapraj/sample-app --force'
                sh 'docker container stop sample-web-app'
                sh 'docker container rm sample-web-app'
            }
        }
    }
}
