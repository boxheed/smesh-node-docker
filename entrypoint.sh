#!/usr/bin/env bash

cd /var/lib/smesh/

java --add-modules java.se --add-exports java.base/jdk.internal.ref=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED   --add-opens java.base/java.nio=ALL-UNNAMED   --add-opens java.base/sun.nio.ch=ALL-UNNAMED   --add-opens java.management/sun.management=ALL-UNNAMED   --add-opens jdk.management/com.ibm.lang.management.internal=ALL-UNNAMED   --add-opens jdk.management/com.sun.management.internal=ALL-UNNAMED -jar ./smesh-server-0.1.1.jar
