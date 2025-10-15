# # Use a small JDK base image
# FROM openjdk:21-jdk-slim

# # Set working directory inside the container
# WORKDIR /app

# # Copy the JAR from local machine to /app in the image
# COPY /home/ubuntu/jenkins_home/workspace/Testing-java-project/target/my-app-1.0-SNAPSHOT.jar app.jar

# # Expose the port your app will run on
# EXPOSE 8090

# # Set the entry point to run the JAR
# ENTRYPOINT ["java", "-jar", "app.jar"]

FROM openjdk:21-jdk-slim

# Set working directory inside container
WORKDIR /app

# Copy the renamed JAR file into the image
COPY target/app.jar app.jar

# Expose port your app will listen on
EXPOSE 8090

# Command to run your Java app
ENTRYPOINT ["java", "-jar", "app.jar"]