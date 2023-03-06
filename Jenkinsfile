pipeline {
	agent any
    stages {
        stage('Docker Build') {
    	agent any
      steps {
      	sh 'docker build -t finalproject:latest .'
      }
    }
  }
}
