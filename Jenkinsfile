pipeline {
    agent any  // Use any available agent (can be adjusted if you want to use Docker as the agent)

    environment {
        DOTNET_CLI_HOME = '/tmp'  // Fix permission issues with dotnet on some environments
    }

    stages {
        // Checkout the code from the SCM (GitHub repository)
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        // Build the .NET project
        stage('Build') {
            steps {
                script {
                    sh 'dotnet build'  // Builds the .NET application
                }
            }
        }

        // Run the .NET tests
        stage('Test') {
            steps {
                script {
                    sh 'dotnet test'  // Executes the tests
                }
            }
        }

        // Build the Docker image for the application
        stage('Docker Build & Push') {
            steps {
                script {
                    sh 'docker build -t myapp .'  // Builds the Docker image with the "myapp" tag
                }
            }
        }

        // Run the Docker container from the built image
        stage('Deploy') {
            steps {
                script {
                    sh 'docker run -d -p 5000:80 myapp'  // Runs the Docker container on port 5000
                }
            }
        }
    }

    post {
        // Clean up Docker containers after the job is finished
        always {
            script {
                sh 'docker system prune -f'  // Cleans up unused Docker objects to free space
            }
        }
    }
}
