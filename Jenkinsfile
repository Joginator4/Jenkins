pipeline {
    agent any
    stages {
            stage('Git checkout') {
                steps{
                    git 'https://github.com/Joginator4/Jenkins'
                }
            }
            stage('Sending Dockerfile to Ansible server'){
                steps{
                    sshagent(['ansible']) {
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.19.243'
                        sh 'scp -r /var/lib/jenkins/workspace/pipeline-test ubuntu@172.31.19.243:/home/ubuntu/'
                }
            }
        }
    }
}