FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get intall openjdk-17-jdk -y

FROM openjdk:17-jdk-slim
COPY . .

RUN apt-get intall maven -y
RUN mvm clean intall

EXPOSE 8080

COPY --from=build /target/tudolist-1.0.0.jar app.jar

ENTRYPOINT [ "java","-jar","app.jar" ]