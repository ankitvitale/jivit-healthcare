# Stage 1: Build the application using Maven
FROM  maven:3.9.6-amazoncorretto-17-a12023 AST build

# Set the working directory inside the container
WORKDIR /app

# Install curl (optional, useful for debugging network connectivity)
RUN apt-get update && apt-get install -y curl

# Ensure Maven is available
RUN mvn -v

# Copy the pom.xml and download dependencies
COPY pom.xml .

# Download dependencies for offline usage (optional)
RUN mvn dependency:go-offline

# Copy the rest of the source code
COPY src ./src

# Build the application (this will create the target/ directory with the JAR file)
RUN mvn clean package -DskipTests

# Stage 2: Create the final image
FROM  openjdk:24-slim-bullseye

# Set working directory for the final image
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/jivitHealcare-0.0.1-SNAPSHOT.jar /app/jivitHealcare-0.0.1-SNAPSHOT.jar

# Expose the application port
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "/app/jivitHealcare-0.0.1-SNAPSHOT.jar"]
