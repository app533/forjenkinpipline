
sudo chmod 666 /var/run/docker.sock

pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t tmujee200/ndockerfile .'
            }
        }
        stage('Test') {
            steps {
                sh 'docker run --rm tmujee200/ndockerfile echo "Container launched successfully"'
            }
        }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: '<fordocker>', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    sh 'docker push tmujee200/ndockerfile'
                }
            }
        }
    }
}









