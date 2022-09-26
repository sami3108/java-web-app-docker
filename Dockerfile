FROM tomcat:8.0.20-jre8
# Dummy text to test 
COPY target/java-web-app-new*.war /usr/local/tomcat/webapps/java-web-app-new.war
