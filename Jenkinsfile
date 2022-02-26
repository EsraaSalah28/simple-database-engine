pipeline {
    agent any
    environment { 
        CC = 'clang'
    }
    stages {
        stage('Example') {
            environment { 
                DEBUG_FLAGS = '-g'
            }
            steps {
                echo 'hiii ${env.CC} , ${env.DEBUG_FLAGS}'
            }
        }
    }
}
