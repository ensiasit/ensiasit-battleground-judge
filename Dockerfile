FROM maven:3.6.3-jdk-11 as maven

COPY ./pom.xml ./pom.xml

RUN mvn dependency:go-offline -B

COPY ./src ./src

RUN mvn package

FROM openjdk:8u171-jre-alpine

WORKDIR /judge

COPY --from=maven target/judge-*.jar ./target/judge.jar

CMD ["java", "-jar", "./target/judge.jar"]