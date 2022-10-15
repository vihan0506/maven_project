FROM ubuntu
RUN apt-get update
RUN apt install -y default-jdk
RUN apt-get install -y curl
RUN apt install -y wget
WORKDIR /tmp
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.62/bin/apache-tomcat-9.0.62.tar.gz
RUN tar xvf apache-tomcat-9.0.62.tar.gz
RUN mv apache-tomcat-9.0.62 /usr/share/apache-tomcat
WORKDIR /usr/share/apache-tomcat/webapps
RUN curl -O -L http://10.127.128.187:8082/ui/native/ankush-test-repo/Example-0.0.1-SNAPSHOT.war
CMD ["/usr/share/apache-tomcat/bin/startup.sh", "run"]
EXPOSE 8080
