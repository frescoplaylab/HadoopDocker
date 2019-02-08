FROM ubuntu:16.04
RUN mkdir /opt/mdp
RUN apt update && apt install curl -y \
    && apt install default-jdk -y \
    && apt-get install openssh-server -y \
    && curl -s "https://archive.apache.org/dist/hadoop/core/hadoop-2.7.6/hadoop-2.7.6.tar.gz"   | tar xzvf -  -C /opt/mdp 
    
COPY ./hadoop-env.sh /opt/mdp/hadoop-2.7.6/etc/hadoop/hadoop-env.sh
COPY ./core-site.xml /opt/mdp/hadoop-2.7.6/etc/hadoop/core-site.xml
COPY ./mapred-site.xml /opt/mdp/hadoop-2.7.6/etc/hadoop/mapred-site.xml
COPY ./yarn-site.xml /opt/mdp/hadoop-2.7.6/etc/hadoop/yarn-site.xml
COPY ./hdfs-site.xml /opt/mdp/hadoop-2.7.6/etc/hadoop/hdfs-site.xml
 



ENV PATH=${PATH}:/opt/mdp/hadoop-2.7.6/sbin
ENV PATH=${PATH}:/opt/mdp/hadoop-2.7.6/bin
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/

COPY ./start.sh .
RUN chmod +x ./start.sh
ENTRYPOINT ["/bin/bash" ,"./start.sh" ]


