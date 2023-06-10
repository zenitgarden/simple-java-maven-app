node {
    docker.image('maven:3.9.0').inside('-v /root/.m2:/root/.m2') {
        stage('Build') {
            echo '--------------------------Build process----------------------------'
            sh 'mvn -B -DskipTests clean package'
        }
        stage('Test') {
            try {
                echo '--------------------------Test process----------------------------'
                sh 'mvn test'
            }
            catch(e) {
                echo 'an error occured'
                throw e
            }
            finally {
                junit 'target/surefire-reports/*.xml'
            }
        }
        stage('Deliver') {
            echo '--------------------------Deliver process----------------------------'
            sh './jenkins/scripts/deliver.sh'
        }
    }
}
