@Library('github.com/releaseworks/jenkinslib') _

pipeline {
	agent any
    stages {
        stage('Docker Build') {
    	agent any
      steps {
      	sh 'docker build -t finalproject:latest .'
      }
    }
    stage('Docker Push'){
      agent any
      steps{
	   withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'aws-key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
        AWS("--region=eu-west-1 s3 ls")
            }  
          sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/f7b5d0k8'
          sh 'docker tag finalprojectorandhila:latest public.ecr.aws/f7b5d0k8/finalprojectorandhila:latest'
          sh 'docker push public.ecr.aws/f7b5d0k8/finalprojectorandhila:latest'
      }
    }
  }
}
