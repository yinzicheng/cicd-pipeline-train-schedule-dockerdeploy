pipeline {
    agent any

    stages {

        stage('Build') {
            steps {
                echo 'building docker image'
                script {
                    app = docker.build("yzchg/train-schedule")
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

        stage('Deploy to Production') {
            when {
                branch 'master'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                withCredentials([usernamePassword(credentialsId: 'node1_ssh_userpass', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    script {
                        def remote = [:]
                        remote.name = 'node1'
                        remote.host = '192.168.1.130'
                        remote.user = USERNAME
                        remote.password = USERPASS
                        remote.allowAnyHosts = true
                        try {
                            sshCommand remote: remote, command: "docker rm -f train-schedule"
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sshCommand remote: remote, command: "docker run --restart always --name train-schedule -dp 8081:8081 yzchg/train-schedule:${env.BUILD_NUMBER}"
                    }
                }
            }
        }

    }
}
