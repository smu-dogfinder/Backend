# Build stage
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests

# Run stage
FROM eclipse-temurin:17-jdk

WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
