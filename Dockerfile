pipeline {
    agent any
 
   environment {
        PATH = "/opt/apache-maven-3.8.5/bin:$PATH"                                                                    
    }
 stages {
      stage('checkout') {
           steps {
             
                git credentialsId: 'gitcredentials', url: 'https://github.com/shivaji219/sample-java-project.git'
             
          }
        }
  stage('Execute Maven') {
           steps {
             
                sh 'mvn package'             
          }
        }
stage('Docker Build and Tag') {
           steps {
              
                sh 'docker build -t dockerpipline:latest .' 
                sh 'docker tag dockerpipline shivaji219/dockerpipline:latest'
                //sh 'docker tag dockerpipline shivaji219/samplewebapp:$BUILD_NUMBER'
               
          }
        }
     
 
      stage('Run Docker container on Jenkins Agent') {
             
            steps 
   {
                sh "docker run -d -p 8003:8080 shivaji219/dockerpipline"
 
            }
        }
 stage('Run Docker container on remote hosts') {
             
            steps {
                sh "docker -H ssh://jenkins@54-145-58-54 run -d -p 8003:8080 shivaji219/dockerpipline"
 
            }
        }
    }
 }
