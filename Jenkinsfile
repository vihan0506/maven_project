pipeline {
  agent { label 'master' }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    CI = true
    /*ARTIFACTORY_ACCESS_TOKEN = credentials('artifactory-access-token')*/
    tomcatWeb = 'C:\\\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps'
    tomcatBin = 'C:\\\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\bin'
    tomcatStatus = ''
    mvnHome =  tool name: 'Maven3.6.3', type: 'maven' 
    imagename = "my-tomcat"
    dockerImage = ''
  }
  
  
  
   
  
  
  
  
  stages {
    
    stage('Compile-Package-create-war-file'){
      steps {
        // Get maven home path
          
        /*bat "${mvnHome}/bin/mvn package"*/
       bat "mvn clean install"
       echo 'Compile completed'
      }
      }
    
    
    
    
    
    
    stage('Artifactory upload to jfrog') {
      steps {
        rtServer(
          id: "jfroginstanceid",
          url: 'http://10.127.128.187:8082/artifactory',
          username: 'access-admin',
          password: 'password',
          bypassProxy: true,
          timeout:300
        )
        rtUpload(
        serverId:"jfroginstanceid",
        spec:'''{
        "files": [
          {
          "pattern": "target/Example-0.0.1-SNAPSHOT.war",
          "target": "ankush-test-repo/"
          }
        ]
        }''',
      )
      rtPublishBuildInfo(
        serverId: "jfroginstanceid"
      )

     }
     }
    
    
    stage('Docker Build'){
      steps{
        bat "docker build . -t my-tomcat"
      }
    }
    
    stage('Docker Run'){
      steps{
        bat "docker run -p 8080:8080 my-tomcat"
      }
    }
    
    
    
   
    /* stage('Deploy to Tomcat'){
       steps {
        bat "copy target\\Example-0.0.1-SNAPSHOT.war	 \"${tomcatWeb}\\Example-0.0.1-SNAPSHOT.war\""
       }
   }*/
      /*stage ('Start Tomcat Server') {
        steps {
          //sleep(time:5,unit:"SECONDS") 
          bat "\"${tomcatBin}\\shutdown.bat\""
          bat "\"${tomcatBin}\\startup.bat\""
          //sleep(time:100,unit:"SECONDS")
        }
   }*/
      
  }
}
