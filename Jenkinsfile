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
        stage('Manual Approval') {
            input(message: 'Lanjutkan ke tahap Deploy?? (Klik "Proceed" untuk lanjut)')
        }
    }
    stage('Deploy') {
        echo '--------------------------Deliver process----------------------------'
         withCredentials([string(credentialsId:'remote-target', variable:'REMOTE_TARGET'), string(credentialsId:'user', variable:'USER')]) {
            sshagent (credentials: ['ssh-agent']) {
                sh 'ssh -o StrictHostKeyChecking=no -l ${USER} ${REMOTE_TARGET} uname -a'
                sh 'ssh -o StrictHostKeyChecking=no -l ${USER} ${REMOTE_TARGET} "cd myfolder/simple-java-maven-app; git pull;"'
                sh 'ssh -o StrictHostKeyChecking=no -l ${USER} ${REMOTE_TARGET} "cd myfolder; sudo docker build -t my-image .;"'
                sh 'ssh -o StrictHostKeyChecking=no -l ${USER} ${REMOTE_TARGET} sudo docker run --rm --name mine my-image'
            }
        }
        sleep(time:1, unit:'MINUTES')
    }
}
