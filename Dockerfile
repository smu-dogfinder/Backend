# Build stage
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /app
COPY . .

# Gradle 프로젝트일 경우
RUN chmod +x ./gradlew && ./gradlew clean build -x test

# Run stage
FROM eclipse-temurin:17-jdk

WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
