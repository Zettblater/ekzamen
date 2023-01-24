pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                withCredentials([usernamePassword(credentialsId: 's', passwordVariable: 'password', usernameVariable: 'username')]) {
    

              sh "docker build -t zettblater/ekz:v$BUILD_ID ."
              sh "docker push zettblater/ekz:v$BUILD_ID"  }
            }
        }
    }
}
