# Etapa 1: Compilación con Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copiar archivos necesarios
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn package

# Etapa 2: Imagen final
FROM eclipse-temurin:17
WORKDIR /app

# Copiar el JAR generado
COPY --from=build /app/target/clientes-api-1.0.jar app.jar

# Exponer puerto 8080 (obligatorio para Cloud Run)
EXPOSE 8080

# Lanzar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]
