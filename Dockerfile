FROM glivron/openjdk-8

WORKDIR /var/lib

# ---------------------------------------------------------------------- tomcat8
ENV TOMCAT_VERSION 8.5.27

RUN (curl -L https://www.apache.org/dist/tomcat/tomcat-8/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz | gunzip -c | tar x) \
 && mv apache-tomcat-$TOMCAT_VERSION tomcat \
 && rm -fR tomcat/webapps/* \
 && cd tomcat/conf \
 && echo '\njava.awt.headless=true' >> catalina.properties \
 && cd ../lib \
 && curl -LO https://jcenter.bintray.com/org/apache/openejb/tomee-loader/1.7.4/tomee-loader-1.7.4.jar \
 && curl -LO https://jcenter.bintray.com/org/glassfish/main/external/jmxremote_optional-repackaged/5.0/jmxremote_optional-repackaged-5.0.jar

ADD server.xml /var/lib/tomcat/conf/
ADD context.xml /var/lib/tomcat/conf/

WORKDIR /var/lib/tomcat
EXPOSE 8080 9875
CMD ["bin/catalina.sh", "run"]
