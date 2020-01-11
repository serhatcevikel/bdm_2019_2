# postgresql, hadoop, hdfs, yarn and sqoop ready, data imported
# install hive and pig
FROM gesiscss/binder-serhatcevikel-2dbdm-5f2019-5f2-1e05af:39519f0d8b03fc711412ad61be1030800d8fb5ca
LABEL maintainer="serhatcevikel@yahoo.com"

# create user
ENV PIG_VERSION 0.17.0
ENV PIG_HOME /opt/pig
ENV HIVE_VERSION 2.3.6
ENV HIVE_HOME /opt/hive
ENV PATH $PIG_HOME/bin:$HIVE_HOME/bin:$PATH

# install pig
USER root
RUN mkdir -p $PIG_HOME && \
    chown -R $NB_UID $PIG_HOME;

USER ${NB_USER}
RUN curl -o /tmp/pig-${PIG_VERSION}.tar.gz \
    http://ftp.itu.edu.tr/Mirror/Apache/pig/pig-${PIG_VERSION}/pig-${PIG_VERSION}.tar.gz && \
    \
    tar -xvf /tmp/pig-${PIG_VERSION}.tar.gz -C ${PIG_HOME} --strip-components=1 && \
    rm /tmp/pig-${PIG_VERSION}.tar.gz;

# install hive
USER root
RUN mkdir -p $HIVE_HOME && \
    chown -R $NB_UID $HIVE_HOME;

USER ${NB_USER}
RUN curl -o /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz \
    http://ftp.itu.edu.tr/Mirror/Apache/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    \
    tar -xvf /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz -C $HIVE_HOME --strip-components=1 && \
    rm /tmp/apache-hive-${HIVE_VERSION}-bin.tar.gz;

USER ${NB_USER}
WORKDIR ${HOME}
