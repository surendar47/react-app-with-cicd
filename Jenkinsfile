pipeline {
    agent any

    stages {
        stage ('changing the file permission') {
            steps {
                sh 'chmod +x react-app-code'
                sh ' cd react-app-code'
                sh ' chmod +x build.sh'
            }
        }

        stage ('executing the file') {
            steps {
                sh './build.sh'
            }
        }
    }
}
