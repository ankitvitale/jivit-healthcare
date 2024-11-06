# # Use OpenJDK 17 from Alpine as the base image
# FROM openjdk:17-jdk-alpine

# # Set working directory
# WORKDIR /app

# # Copy pom.xml and install Maven dependencies
# COPY pom.xml .

# # Copy the source code into the container
# COPY src ./src

# # Run the Maven build to package the JAR (Make sure you run mvn clean package locally first)
# RUN mvn clean package -DskipTests

# # Copy the JAR file from the target folder
# COPY target/jivitHealcare-0.0.1-SNAPSHOT.jar /app/jivitHealcare-0.0.1-SNAPSHOT.jar

# # Expose the port on which the app will run
# EXPOSE 8080

# # Run the JAR file
# ENTRYPOINT ["java", "-jar", "/app/jivitHealcare-0.0.1-SNAPSHOT.jar"]



# Stage 1: Build the application using Maven
FROM maven:3.8.6-openjdk-17 AS build
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

