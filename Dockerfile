# Stage 1: Build the WAR using Maven and Java 17
FROM maven:3.8.5-openjdk-17 AS builder

WORKDIR /app
COPY . .
RUN mvn clean package

# Stage 2: Run the WAR with Tomcat 9 (Java 17 compatible)
FROM tomcat:9.0-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

