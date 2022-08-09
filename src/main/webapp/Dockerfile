FROM tomcat:latest
LABEL maintainer="shivaji219"
ADD ./target/sample-java-web-project.war /usr/local/tomcat/webapps/
EXPOSE 8090
CMD ["catalina.sh", "run"]
