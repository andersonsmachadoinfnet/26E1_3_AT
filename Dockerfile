FROM eclipse-temurin:21-jdk AS build
LABEL authors="Anderson"

WORKDIR /app
COPY pom.xml mvnw ./
COPY .mvn .mvn

RUN ./mvnw dependency:go-offline -B
COPY src src
RUN ./mvnw clean package -DskipTests

# Etapa II
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Finalizando
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
