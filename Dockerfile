FROM openjdk:11.0.6-jdk-slim-buster

ADD install_packages /usr/sbin/
RUN chmod 755 /usr/sbin/install_packages

RUN install_packages curl

RUN mkdir -p /var/lib/smesh \
  && cd /var/lib/smesh/ \
  && curl -L "https://dl.bintray.com/boxhead/maven/com/fizzpod/smesh-server/0.1.2/smesh-server-0.1.2.jar" -o smesh-server.jar

# Add empty application configuration file
ADD application.yml /var/lib/smesh/

# Add server conf file
ADD smesh-server.conf /var/lib/smesh/

# Add dedicated user to run the node
RUN groupadd -r smesh-node && useradd -r -g smesh-node smesh-node

# Set the correct permissions on the files
RUN chown smesh-node:smesh-node /var/lib/smesh/* \
  && chmod 400 /var/lib/smesh/* \
  && chmod 500 /var/lib/smesh/*.jar

# Switch to the smesh-node user
USER smesh-node

WORKDIR /var/lib/smesh/

ENTRYPOINT  ["./smesh-server.jar"]
