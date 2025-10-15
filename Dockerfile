# Use a small JDK base image
FROM openjdk:21-jdk-slim

# Set working directory
WORKDIR /app

# Copy the built JAR file into the container
COPY  /home/ubuntu/jenkins_home/workspace/Testing-java-project/target/my-app-1.0-SNAPSHOT.jar

# Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
EXPOSE 8090

