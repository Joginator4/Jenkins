pipeline {
    agent {
        node {
            label 'jenkins-agent'
            }
        }
    stages {
        stage('Git checkout') {
            steps{
                git 'https://github.com/Joginator4/Jenkins'
            }
        }
    }
}