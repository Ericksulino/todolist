# Use uma imagem base oficial do OpenJDK
FROM openjdk:17-jdk-slim AS build

# Instale o Maven e as dependências
RUN apt-get update && apt-get install -y maven

# Copie o código-fonte da aplicação para o contêiner
COPY . /app

# Defina o diretório de trabalho
WORKDIR /app

# Compile a aplicação
RUN mvn clean install

# Estágio final para a imagem em tempo de execução
FROM openjdk:17-jdk-slim

# Copie o arquivo JAR construído do estágio de compilação
COPY --from=build /app/target/todolist-1.0.0.jar /app.jar

# Exponha a porta na qual a aplicação será executada
EXPOSE 8080

# Defina o comando para executar a aplicação
CMD ["java", "-jar", "/app.jar"]
