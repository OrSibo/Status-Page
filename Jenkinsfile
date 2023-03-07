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
      stage('Docker Pull'){
        agent any
      steps{
        sh 'ssh-keygen -t rsa -f ~/.ssh/id_rsa4'
        echo 'key'
        sh 'chmod 644 /var/lib/jenkins/.ssh/id_rsa4.pub'
        echo 'chmod'
        sh 'scp /var/lib/jenkins/.ssh/id_rsa4.pub ubuntu@3.253.71.184'
        echo 'copy'
        sh 'ssh -i ~/.ssh/id_rsa4.pub ubuntu@3.253.71.184'
        withCredentials([aws(credentialsId: 'aws-cli-use', defaultRegion: 'us-east-1')]){ 
          sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/f7b5d0k8'
          sh 'docker pull public.ecr.aws/f7b5d0k8/finalprojectorandhila:latest'}
        }
      }
    } 
}
