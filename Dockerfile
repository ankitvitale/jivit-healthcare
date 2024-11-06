
# Stage 1: Build the application using Maven
FROM maven:3.8.6
WORKDIR /app

# Install curl to check network connectivity if necessary
RUN apt-get update && apt-get install -y curl

# Ensure Maven is available
RUN mvn -v

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the source code
COPY src ./src

# Build the application (this will create the target/ directory with the JAR file)
RUN mvn clean package -DskipTests

# Stage 2: Create the final image
FROM openjdk:17-jdk-alpine
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/jivitHealcare-0.0.1-SNAPSHOT.jar /app/jivitHealcare-0.0.1-SNAPSHOT.jar

# Expose the application port
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "/app/jivitHealcare-0.0.1-SNAPSHOT.jar"]

