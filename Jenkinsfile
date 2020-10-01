pipeline {
    agent {
        docker {
            image 'node:14-alpine3.10'
            args '-p 3000:3000'
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
                archiveArtifacts artifacts: 'dist/trainSchedule.zip'
                withCredentials([usernamePassword(credentialsId: 'node1_ssh_userpass', usernameVariable: 'UNAME', passwordVariable: 'UPASS')]) {
                    script {
                        def remote = [:]
                        remote.name = 'node1'
                        remote.host = '192.168.1.130'
                        remote.user = UNAME
                        remote.password = UPASS
                        remote.allowAnyHosts = true
                        sshPut remote: remote, from: 'dist/trainSchedule.zip', into: '/tmp'
                        sshCommand remote: remote, command: '''
                            rm -rf /vagrant/jenkins/deploy/trainSchedule &&
                            mkdir -p /vagrant/jenkins/deploy/trainSchedule &&
                            unzip /tmp/trainSchedule.zip -d /vagrant/jenkins/deploy/trainSchedule &&
                            /home/vagrant/.nvm/versions/node/v14.12.0/bin/npm start --prefix /vagrant/jenkins/deploy/trainSchedule &
                        '''
                    }
                }
            }
        }
    }

}
