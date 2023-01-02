pipeline {
    agent any
    stages {
            stage('Git checkout') {
                steps{
                    git 'https://github.com/Joginator4/Jenkins'
                    sh 'echo blaba'
                }
            }
            stage('Sending Dockerfile to Ansible server'){
                steps{
                    sshagent(credentials: ['ansible']) {
                        sh 'ssh -o  StrictHostKeyChecking=no ubuntu@172.31.19.243'
                        sh 'scp /var/lib/jenkins/workspace/pipeline-test/Dockerfile ubuntu@172.31.19.243:/home/ubuntu/test/'
                }
            }
        }
        stage('Login to docker and build image by Ansible'){
                steps{
                    sshagent(credentials: ['ansible']) {
                        sh ''' #!/bin/bash
                        ssh -o StrictHostKeyChecking=no ubuntu@172.31.19.243 cd /home/ubuntu/test/
                        ssh -o StrictHostKeyChecking=no ubuntu@172.31.19.243 docker build -t $JOB_NAME:v1.$BUILD_ID .
                        ssh -o StrictHostKeyChecking=no ubuntu@172.31.19.243 docker image tag $JOB_NAME:v1.$BUILD_ID 867452:1.0
                        '''
                }
            }
        }
        stage('Pushing image to registry'){
            steps{
                sshagent(credentials:['ansible']) {
                    withCredentials([string(credentialsId: 'DOCKERHUB_PASSWORD', variable: 'DOCKERHUB_PASSWORD')]) {
                        sh ''' #!/bin/bash
                        ssh -o StrictHostKeyChecking=no ubuntu@172.31.19.243
                        docker login -u 867452 -p ${DOCKERHUB_PASSWORD}
                        docker push $JOB_NAME:v1.$BUILD_ID
                        '''
                    }
                }
            }
        }
    }
}