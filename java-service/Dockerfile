FROM maven:3.9.2-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package

FROM eclipse-temurin:17
WORKDIR /app
COPY --from=build /app/target/clientes-api-1.0.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]