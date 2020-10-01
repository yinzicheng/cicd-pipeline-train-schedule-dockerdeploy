pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'building docker image'
                script {
                    app = docker.build("yzchg/train-schedule")
                    app.inside {
                        sh 'echo $(curl localhost:8081)'
                    }
                }
            }
        }
        stage('Publish') {
            steps {
                echo 'publish docker image'
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
    }
}
