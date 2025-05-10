pipeline {
  agent any

  environment {
    IMAGE_NAME = 'wole9548/javaweb3'           // Your Docker Hub repo
    DOCKER_CREDS_ID = 'dockerhub-creds-id'     // Jenkins Credentials ID for Docker Hub
    VERSION = 'v1'                              // Version tag for the image
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm                          // ✅ Fixes missing pom.xml issue
      }
    }

    stage('Clean Workspace') {
      steps {
        deleteDir()                           // Optional: wipe old files before build
      }
    }

    stage('Build WAR with Maven') {
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
      echo "✅ JavaWeb3 CI/CD pipeline completed successfully!"
    }
    failure {
      echo "❌ Build failed. Check the logs above."
    }
  }
}

