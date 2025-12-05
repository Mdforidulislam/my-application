pipeline {
  agent any

  environment {
    IMAGE_NAME = "devforidul/my-next-app"
  }

  stages {

    stage("Build Docker Image") {
      steps {
        sh "docker build -t $IMAGE_NAME:latest ."
      }
    }

    stage("Login to Docker Hub") {
      steps {
        withCredentials([usernamePassword(
          credentialsId: "dockerhub-creds",
          usernameVariable: "DOCKER_USER",
          passwordVariable: "DOCKER_PASS"
        )]) {
          sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
        }
      }
    }

    stage("Push Image to Docker Hub") {
      steps {
        sh "docker push $IMAGE_NAME:latest"
      }
    }

  }
}
