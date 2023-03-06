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
	      withCredentials([AWS Credentials(credentialsId: 'aws-cli-use', defaultRegion: 'us-east-1')]){
          sh 'aws ecr-public get-login-password --region eu-west-1 | docker login --username AWS --password-stdin public.ecr.aws/f7b5d0k8'
          sh 'docker tag finalprojectorandhila:latest public.ecr.aws/f7b5d0k8/finalprojectorandhila:latest'
          sh 'docker push public.ecr.aws/f7b5d0k8/finalprojectorandhila:latest'
	    }
      }
    }
  }
}
