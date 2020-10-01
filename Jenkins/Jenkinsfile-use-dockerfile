pipeline {
    agent {
        docker {
            image 'node:14-alpine3.10'
            args '-p 88:8080'
        }
    }
    stages {
        stage('Build') {
            steps {
                echo 'Running build inside node container'
                sh 'npm install'
                archiveArtifacts artifacts: 'dist/trainSchedule.zip'
            }
        }
        stage('Deploy'){
            steps{
                echo 'start app'
                sh 'npm start &'
            }
        }
    }
}
