pipeline {
    agent any
 environment {

    ANSIBLE_PRIVATE_KEY=credentials('ssh-key')
}
     triggers { 
      pollSCM '* * * * *'
        }
    stages {
        stage('Build') {
            steps {
                withCredentials([usernamePassword(credentialsId: 's', passwordVariable: 'password', usernameVariable: 'username')]) {
    

              sh "docker build -t zettblater/ekz:v$BUILD_ID ."
              sh "docker push zettblater/ekz:v$BUILD_ID"  }
            }
        }
        stage('Deploy') {
            steps { withCredentials([usernamePassword(credentialsId: 's', passwordVariable: 'password', usernameVariable: 'username')]) {
              sh "ansible-playbook playbook.yaml -u ansiblo --private-key=$ANSIBLE_PRIVATE_KEY -e password=$password -e username=$username -e BUILD_ID=$BUILD_ID --become -i inventory" }
            }
        }

    }
    
post {
     success { 
        withCredentials([string(credentialsId: 'chatchat', variable: '5857110328:AAGZjKSrMeua8hd1b_iDlPJCQXeiafhsYbk'), string(credentialsId: 'chatId', variable: 'CHAT_ID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode=markdown -d text='*${env.JOB_NAME}* : POC *Branch*: ${env.GIT_BRANCH} *Build* : OK *Published* = YES'
        """)
        }
     }

     aborted {
        withCredentials([string(credentialsId: 'chatchat', variable: '5857110328:AAGZjKSrMeua8hd1b_iDlPJCQXeiafhsYbk'), string(credentialsId: 'chatId', variable: 'CHAT_ID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode=markdown -d text='*${env.JOB_NAME}* : POC *Branch*: ${env.GIT_BRANCH} *Build* : `Aborted` *Published* = `Aborted`'
        """)
        }
     
     }
     failure {
        withCredentials([string(credentialsId: 'chatchat', variable: '5857110328:AAGZjKSrMeua8hd1b_iDlPJCQXeiafhsYbk'), string(credentialsId: 'chatId', variable: 'CHAT_ID')]) {
        sh  ("""
            curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode=markdown -d text='*${env.JOB_NAME}* : POC  *Branch*: ${env.GIT_BRANCH} *Build* : `not OK` *Published* = `no`'
        """)
        }
     }

 }
}
