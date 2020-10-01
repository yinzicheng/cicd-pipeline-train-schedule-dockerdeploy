pipeline {
    agent {
        docker {
            image 'node:14-alpine3.10'
        }
    }

    stages {
        stage('Build') {
            steps {
                echo 'Running build inside node container'
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Running test'
                sh 'npm test'
            }
        }

        stage('Deploy') {
            steps {
                echo 'start app'
//                sh 'npm start &'
//                input 'Is app running?'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'dist/trainSchedule.zip', fingerprint: true
        }
    }

}
