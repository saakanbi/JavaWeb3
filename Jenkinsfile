pipeline {
  agent any

  environment {
    IMAGE_NAME = 'wole9548/javaweb3'           // Your Docker Hub repo
    DOCKER_CREDS_ID = 'dockerhub-creds-id'     // Credentials ID from Jenkins
    VERSION = 'v1'                              // Static version tag
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/CeeyIT-Solutions/JavaWeb3.git' // Or your own forked repo
      }
    }

    stage('Build WAR') {
      steps {
        sh 'mvn clean package'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build("${IMAGE_NAME}:${VERSION}")
        }
      }
    }

    stage('Push to Docker Hub') {
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
      echo "✅ Successfully pushed ${IMAGE_NAME}:${VERSION} and :latest to Docker Hub"
    }
    failure {
      echo "❌ Build or push failed. Check logs above."
    }
  }
}

