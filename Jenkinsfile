pipeline {
    agent any
    
    tools {
        nodejs "node" // Ensure 'node' is configured in Jenkins Global Tool Configuration
    }
    
    environment {
        BUILD_VERSION = "${BUILD_NUMBER}" // Jenkins environment variable for build number
        DOCKER_LOGIN = "docker_hub_credentials" // Jenkins credentials ID for Docker Hub
        IMAGE_NAME = "bhoomika2897n/nodejs-service1" // Base Docker image name
    }
    
    parameters {
        choice(choices: ['main', 'master'], description: 'Please select branch name', name: 'BRANCH_NAME')
    }
    
    stages {
        stage('Node.js Version Check') {
            steps {
                echo "Checking the Node.js version..."
                sh 'node -v'
                sh 'which node'
            }
        }
        
        stage('Git Clone') {
            steps {
                echo "Cloning repository..."
                git branch: "${params.BRANCH_NAME}", url: "https://github.com/bhoomikakrish/NodeJs_project-1.git"
            }
        }
        
        stage('Build') {
            steps {
                echo "Installing dependencies..."
                sh 'npm install'
            }
        }
        
        stage('Docker Build & Push') {
            steps {
                echo "Building and pushing Docker image..."
                script {
                    // Build Docker image with build-specific tag
                    def dockerImage = docker.build("${IMAGE_NAME}:${BUILD_VERSION}")
                    
                    // Push Docker image to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_LOGIN) {
                        dockerImage.push() // Push the build-specific tag
                        dockerImage.push("latest") // Push the 'latest' tag
                    }
                }
            }
        }
    }
}
