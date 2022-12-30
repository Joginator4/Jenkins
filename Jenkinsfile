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
                    sshagent(credentials: ['ansible']) {
                        sh 'ssh -o  StrictHostKeyChecking=no ubuntu@172.31.19.243'
                        sh 'scp -r /var/lib/jenkins/workspace/pipeline-test ubuntu@172.31.19.243:/home/ubuntu/'
                }
            }
        }
        stage('Login to docker and build image by Ansible'){
                steps{
                    sshagent(credentials: ['ansible']) {
                        sh 'ssh -o StrickHostKeyChecking=no ubuntu@172.31.19.243'
                        cd $HOME/pipeline-test
                        docker build -t nginx:1.0 .
                }
            }
        }
    }
}