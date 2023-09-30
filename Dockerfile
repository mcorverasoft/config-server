#MVN container
FROM maven:3.8.6-jdk-11-slim as builder
COPY . /app/
WORKDIR /app
RUN mvn clean package install -DskipTests
#Java container
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=builder /app/target/* ./app/
ENTRYPOINT ["java","-jar","./app/config-server.jar"]