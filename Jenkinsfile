pipeline {
    
    agent { label 'jenkins-worker' }

    tools {
       maven '3.8.6'
    }
 
    stages {

        stage('Checkout external proj') {
           steps {
             git branch: 'master',
                credentialsId: 'cb067715-9f4b-4f93-93ff-d4fa802a8c71',
                url: 'https://github.com/deeprangaraj/SampleWebApp'
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
                sh 'docker run -p 8080:8080 -d --name sample-web-app-3 deepapraj/sample-app'
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
                sh 'docker remove image deepapraj/sample-app --force'
            }
        }

    }
}
