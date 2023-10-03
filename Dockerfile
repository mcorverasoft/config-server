# Use an official Maven image as the parent image
FROM maven:3.8.4-openjdk-11-slim AS build
# Set the working directory in the container
WORKDIR /app
# Copy the pom.xml and install dependencies
COPY pom.xml .
RUN mvn dependency:go-offline
# Copy the application files and build the project
COPY src ./src
RUN mvn package -DskipTests
# Create a new image with the JRE only
FROM openjdk:11-jre-slim
# Set the working directory in the container
WORKDIR /app
# Copy the built JAR file from the build image
COPY --from=build /app/target/config-server.jar ./app.jar
# Expose the port the application will run on
EXPOSE 8005
# Specify the command to run the application
CMD ["java", "-jar", "app.jar"]





