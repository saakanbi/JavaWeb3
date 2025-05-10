pipeline {
  agent any

  environment {
    IMAGE_NAME = 'wole9548/javaweb3'
    DOCKER_CREDS_ID = 'dockerhub-creds-id'
    VERSION = 'v1'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build and Package') {
      steps {
        sh 'mvn clean package -Dmaven.compiler.source=1.8 -Dmaven.compiler.target=1.8'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build("${IMAGE_NAME}:${VERSION}")
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        script {
          docker.withRegistry('', DOCKER_CREDS_ID) {
            docker.image("${IMAGE_NAME}:${VERSION}").push()
            docker.image("${IMAGE_NAME}:${VERSION}").push('latest')
          }
        }
      }
    }
  }

  post {
    success {
      echo '✅ Pipeline succeeded.'
    }
    failure {
      echo '❌ Pipeline failed. Check the logs.'
    }
  }
}
