pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building the App ..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing the App ..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying the App ..'
            }
        }
    }
    post {
        always {
            echo 'Cleaning up workspace'
        }
    success {
    echo "${env.JOB_NAME} Successful build"
            }
    }
    failure{
        echo "${env.JOB_NAME} Failed build"
    }
    
}
