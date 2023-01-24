pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                withCredentials([usernamePassword(credentialsId: 's', passwordVariable: 'password', usernameVariable: 'username')]) {
    

              sh "docker build -t zettblater/sharks:v$BUILD_ID ."
              sh "docker push zettblater/sharks:v$BUILD_ID"  }
            }
        }
    }
}
