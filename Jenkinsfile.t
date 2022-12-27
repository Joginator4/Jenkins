pipeline {
    agent { 
        node {
            label 'jenkins-python'
            }
      }
    stages {
        stage('Build') {
            steps{
                echo "Building.."
                sh
                echo "Building stuff"
            }
        }
        }
}