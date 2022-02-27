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
            when {
              expression {
                BRANCH_NAME=='myy'
              }
            }
            steps {
               echo 'Deploying the App ..'
            }
        }
    }
}
