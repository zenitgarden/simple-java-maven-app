echo 'Deploying to the EC2 instance'
echo 'The following Maven command builds the project and packages the resulting JAR file into the target directory.'
mvn package

echo 'Run the project'
echo 'The following command run the jar file in target/my-app-1.0-SNAPSHOT.jar'
echo 'the result prints "hello world"'
java -jar target/my-app-1.0-SNAPSHOT.jar
