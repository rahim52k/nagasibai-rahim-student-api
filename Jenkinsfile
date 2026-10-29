pipeline {
    agent any

    environment {
        IMAGE_NAME = 'nagasibai-rahim-student-api:v1.0-rahim'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo 'Student: Nagasibai Rahim'
            }
        }
        stage('Build') {
            steps {
                sh 'chmod +x gradlew 2>/dev/null || true'
                sh 'gradle --no-daemon clean bootJar'
            }
        }
        stage('Test') {
            steps {
                sh 'gradle --no-daemon test'
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t "$IMAGE_NAME" .'
            }
        }
        stage('Verify') {
            steps {
                sh 'docker image inspect "$IMAGE_NAME" --format="Image={{.RepoTags}} Size={{.Size}} bytes Created={{.Created}}"'
                echo 'Build and verification completed for Nagasibai Rahim.'
            }
        }
    }
    post {
        success { echo 'SUCCESS: Nagasibai Rahim student API pipeline passed.' }
        failure { echo 'FAILED: inspect the stage and console output above.' }
        always { junit allowEmptyResults: true, testResults: 'build/test-results/test/*.xml' }
    }
}
