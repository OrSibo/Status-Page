pipeline {
  agent any
    stages {
        stage('Docker Build') {
       agent any
      steps {
      	sh 'docker build -t finalprojectorandhila .'
      }
    }
    stage('Docker Push'){
      agent any
    steps{
    withCredentials([aws(credentialsId: 'aws-cli-use', defaultRegion: 'us-east-1')]){ 
          sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/f7b5d0k8'
          sh 'docker tag finalprojectorandhila:latest public.ecr.aws/f7b5d0k8/finalprojectorandhila:latest'
          sh 'docker push public.ecr.aws/f7b5d0k8/finalprojectorandhila:latest'
        }
      }
    }   
    stage ('Deploy') {
      agent any
    steps{
        withCredentials([sshUserPrivateKey(credentialsId:'shh-server')]) {
            sh 'scp deploy.sh ubuntu@3.253.71.184'
            sh 'ssh ubuntu@3.253.71.184 "chmod +x deploy.sh"'
            sh 'ssh ubuntu@3.253.71.184 ./deploy.ssh'
          }
        }
      }
  }
}  
