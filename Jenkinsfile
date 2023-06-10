node {
    docker.image('maven:3.9.0').inside('-v /root/.m2:/root/.m2') {
        stage('Build') {
            sh 'mvn -f /home/zenit/dicoding/simple-java-maven-app/pom.xml'
            sh 'mvn -B -DskipTests clean package'
        }
        stage('Test') {
            try {
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
            sh './jenkins/scripts/deliver.sh'
        }
    }
}
