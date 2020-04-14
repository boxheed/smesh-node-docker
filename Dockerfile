FROM openjdk:11.0.6-jdk-slim-buster

ADD install_packages /usr/sbin/
RUN chmod 755 /usr/sbin/install_packages

RUN install_packages curl

RUN mkdir -p /var/lib/smesh \
  && cd /var/lib/smesh/ \
  && curl -L "https://dl.bintray.com/boxhead/maven/com/fizzpod/smesh-server/0.1.2/smesh-server-0.1.1.jar" -o smesh-server-0.1.1.jar

# Add empty configuration file
ADD application.yml /var/lib/smesh/

# Add startup script
ADD entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

# Add dedicated user to run the node
RUN groupadd -r smesh-node && useradd -r -g smesh-node smesh-node

USER smesh-node

ENTRYPOINT  ["/opt/entrypoint.sh"]
