pipeline {
    agent any
    environment {
        ANSIBLE_WORKSPACE = '/home/ubuntu/ansible-inventory'
        ANSIBLE_SERVER =  'ssh -o  StrictHostKeyChecking=no ubuntu@172.31.19.243s'
        
    }
    stages {
            stage('Cloning repository') {
                steps{
                    git 'https://github.com/Joginator4/Jenkins'
                    
                }
            }
            stage('Preparing Dockerfile on ansible server'){
                steps{
                    sshagent(credentials: ['ansible']) {
                        sh 'ssh -o  StrictHostKeyChecking=no ubuntu@172.31.19.243'
                        sh 'scp $WORKSPACE/Dockerfile ubuntu@172.31.19.243:/home/ubuntu/test/'
                }
            }
        }
        stage('Login to docker and build nginx image'){
                steps{
                    sshagent(credentials: ['ansible']) {
                        sh """ #!/bin/bash
                        ssh -o StrictHostKeyChecking=no ubuntu@172.31.19.243 cd /home/ubuntu/test/
                        ssh -o StrictHostKeyChecking=no ubuntu@172.31.19.243 docker build -t $JOB_NAME:v1.$BUILD_ID .
                        ssh -o StrictHostKeyChecking=no ubuntu@172.31.19.243 docker image tag $JOB_NAME:v1.$BUILD_ID 867452:1.0
                        """
                }
            }
        }
        stage('Pushing image to dockerhub registry'){
            steps{
                sshagent(credentials:['ansible']) {
                    withCredentials([string(credentialsId: 'DOCKERHUB_PASSWORD', variable: 'docker_password')]) {
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.19.243 docker login -u 867452 -p ${docker_password}"
                        sh "ssh -o StrictHostKeyChecking=no  ubuntu@172.31.19.243 docker tag $JOB_NAME:v1.$BUILD_ID 867452/jenkins_repo:v1.$BUILD_ID"
                        sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.19.243 docker image push 867452/jenkins_repo:v1.$BUILD_ID"
                    }
                }
            }
        }
        stage('Preparing Ansible files'){
            steps{
                sshagent(credentials:['ansible']) {
                    sh """ #/bin/bash
                    ssh -o StrictHostKeyChecking=no ubuntu@172.31.19.243 cd /home/ubuntu/Kubernetes_yaml"
                    scp -r ubuntu@172.31.11.235:$WORKSPACE/Kubernetes/env_variables ubuntu@172.31.19.243:/home/ubuntu/Kubernetes_yaml"
                    ssh -o StrictHostKeyChecking=no ubuntu@172.31.19.243 cd /home/ubuntu/Kubernetes_yaml"
                    scp -r ubuntu@172.31.11.235:$WORKSPACE/Kubernetes/playbook.yml ubuntu@172.31.19.243:/home/ubuntu/ansible-inventory"
                    """
                }
            }
        }
        stage('Running Ansible Playbook'){
            steps{
                sshagent(credentials:['ansible']) {
                    sh """ #!/bin/bash
                    ssh -o StrictHostKeyChecking=no ubuntu@172.31.19.243 cd /home/ubuntu/ansible-inventory"
                    ansible-playbook playbook.yml"
                    """
                }               
            }
        }    
    }
}