FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 9090
ADD springboot-wechat-cp-1.0.jar wechat-cp-1.0.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/wechat-cp-1.0.jar"]
