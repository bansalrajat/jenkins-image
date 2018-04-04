FROM ubuntu:latest

MAINTAINER RajatBansal

ENV M2_VERSION "3.5.3"
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install wget unzip
WORKDIR /opt
RUN echo "`hostname -i`"
RUN ["pwd"]
RUN id
RUN echo "`ls -ltr /`"
RUN cd $HOME
RUN which wget
RUN cat /etc/resolv.conf

#Install Tomcat 8
RUN wget  http://192.168.33.13:8081/nexus/service/local/repositories/thirdparty/content/fakepath/apache-tomcat/8.5.20.tar/apache-tomcat-8.5.20.tar.gz -P /opt
RUN tar xvfz apache-tomcat-8.5.20.tar.gz
ENV CATALINA_HOME=/opt/apache-tomcat-8.5.20

#Install JDK
RUN wget  http://192.168.33.13:8081/nexus/service/local/repositories/releases/content/fakepath/jdk/8u144-linux/jdk-8u144-linux-x64.tar.gz -P /opt
RUN tar xvf jdk-8u144-linux-x64.tar.gz
ENV JAVA_HOME="/opt/jdk1.8.0_144"

#Install Maven
RUN wget  http://192.168.33.13:8081/nexus/service/local/repositories/releases/content/fakepath/apache-maven/3.5.2/apache-maven-3.5.2-bin.zip -P /opt
RUN unzip apache-maven-3.5.2-bin.zip
ENV M2_HOME="/opt/apache-maven-3.5.2"

RUN wget http://192.168.33.13:8081/nexus/service/local/repositories/releases/content/fakepath/jenkins/2.107.1/jenkins-2.107.1.war
RUN mv /opt/jenkins-2.107.1.war $CATALINA_HOME/webapps/jenkins.war

ENV PATH=$M2_HOME/bin:$JAVA_HOME/bin:$CATALINA_HOME/bin:$PATH
ENV JENKINS_HOME=/var/jenkins_home
#RUN chmod -R +x $CATALINA_HOME
#RUN /usr/bin/which find
#RUN find /opt -name startup.sh
EXPOSE 8080
CMD "$CATALINA_HOME/bin/catalina.sh" run
#ENTRYPOINT  ["$CATALINA_HOME/bin/startup.sh"]

