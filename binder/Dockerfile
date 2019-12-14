# configure hive
FROM gesiscss/orc-binder-serhatcevikel-2dbdm-5f2019-5f2-1e05af:bc93be85e47bb1b719989f9b07247f000ac07e83
LABEL maintainer="serhatcevikel@yahoo.com"

COPY --chown=jovyan:jovyan . ${HOME}

ENV HIVE_CONF_DIR $HIVE_HOME/conf
ENV HADOOP_CLASSPATH $HADOOP_CLASSPATH:$HIVE_HOME/lib/
ENV HCAT_HOME $HIVE_HOME/hcatalog
ENV PATH $PATH:$HCAT_HOME/bin
ENV PIG_CLASSPATH $HCAT_HOME/share/hcatalog/hive-hcatalog-core*.jar:$HCAT_HOME/share/hcatalog/hive-hcatalog-pig-adapter*.jar:$HIVE_HOME/lib/hive-metastore-*.jar:$HIVE_HOME/lib/libthrift-*.jar:$HIVE_HOME/lib/hive-exec-*.jar:$HIVE_HOME/lib/libfb303-*.jar:$HIVE_HOME/lib/jdo2-api-*-ec.jar:$HIVE_HOME/conf:$HADOOP_HOME/conf:$HIVE_HOME/lib/slf4j-api-*.jar

USER root

RUN apt install -y \
    openjdk-8-jdk; \
    \
    # change java version
    rm /usr/lib/jvm/default-java; \
    ln -s /usr/lib/jvm/java-8-openjdk-amd64 /usr/lib/jvm/default-java; \
    rm /etc/alternatives/java; \
    ln -s /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java /etc/alternatives/java;


USER ${NB_USER}
RUN cp ${HOME}/hive_config/* $HIVE_HOME/conf/ && \
    schematool -initSchema -dbType derby && \
    ln -s $HIVE_HOME/lib/derby-10.10.2.0.jar $SQOOP_HOME/lib/derby-10.10.2.0.jar; \
    ln -s $HIVE_HOME/lib/hive-exec-2.3.6.jar $SQOOP_HOME/lib/hive-exec-2.3.6.jar; \
    ln -s /opt/hadoop-2.9.2/share/hadoop/common/lib/slf4j-api-1.7.25.jar /opt/hive/lib/slf4j-api-1.7.25.jar; \
    \
    bash -c "rm -r ${HOME}/{binder,hive_config}";

USER ${NB_USER}
WORKDIR ${HOME}


