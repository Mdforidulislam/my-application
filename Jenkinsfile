pipeline {
    agent {
        docker {
            // Use Docker-in-Docker image
            image 'docker:24-dind'
            // Required for Docker commands inside container
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        IMAGE_NAME = "devforidul/my-next-app"
    }

    stages {

        stage("Build Docker Image") {
            steps {
                echo "Building Docker image..."
                sh "docker build -t $IMAGE_NAME:latest ."
            }
        }

        stage("Login to Docker Hub") {
            steps {
                echo "Logging in to Docker Hub..."
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
                echo "Pushing Docker image..."
                sh "docker push $IMAGE_NAME:latest"
            }
        }

    }

    post {
        success {
            echo "Docker image pushed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs for details."
        }
    }
}
