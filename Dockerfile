FROM maven:3.8.4-jdk-11-slim AS builder
WORKDIR /app
COPY . .
RUN mvn clean package install -DskipTests && \
    mv /app/target/*.jar /app/config-server.jar

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=builder /app/config-server.jar ./
ENTRYPOINT ["java", "-jar", "./config-server.jar"]