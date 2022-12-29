pipeline {
    agent {
        node {
            label 'jenkins-python'
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