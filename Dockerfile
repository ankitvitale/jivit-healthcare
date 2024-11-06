# Use OpenJDK 17 from Alpine as the base image
FROM openjdk:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy pom.xml and install Maven dependencies
COPY pom.xml .

# Copy the source code into the container
COPY src ./src

# Run the Maven build to package the JAR (Make sure you run mvn clean package locally first)
RUN mvn clean package -DskipTests

# Copy the JAR file from the target folder
COPY target/jivitHealcare-0.0.1-SNAPSHOT.jar /app/jivitHealcare-0.0.1-SNAPSHOT.jar

# Expose the port on which the app will run
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "/app/jivitHealcare-0.0.1-SNAPSHOT.jar"]
