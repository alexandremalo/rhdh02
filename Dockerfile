FROM maven:3.9.8-eclipse-temurin-21 as stage1

WORKDIR /opt/demo
COPY pom.xml .

COPY ./src ./src
RUN mvn clean install -Dmaven.test.skip=true

FROM eclipse-temurin:21-jre
WORKDIR /opt/demo
COPY --from=stage1 /opt/demo/target/*.jar /opt/demo/demo.jar
CMD java -jar /opt/demo/demo.jar

