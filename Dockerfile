FROM ubuntu:20.04

MAINTAINER deepa.rraj

RUN apt -y update
RUN apt -y install curl
RUN apt -y install tar
RUN apt -y install default-jdk
RUN java -version

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.58/bin/apache-tomcat-9.0.58.tar.gz
RUN tar xvf apache*.tar.gz
RUN mv apache-tomcat-9.0.58/* /opt/tomcat/.
#COPY ./custom-users.xml /opt/tomcat/conf/tomcat-users.xml
#COPY ./custom-context.xml /opt/tomcat/webapps/manager/META-INF/context.xml
COPY ./target/SampleWebApp.war /opt/tomcat/webapps

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
