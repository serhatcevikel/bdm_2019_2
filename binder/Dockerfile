# hadoop installation/configuration - base 1
FROM gesiscss/orc-binder-serhatcevikel-2dbdm-5f2019-5f2-1e05af:47996d8eeb6ab02440601c164f15fd40323c5010
LABEL maintainer="serhatcevikel@yahoo.com"

COPY --chown=jovyan:jovyan . ${HOME}

# set environment variables
ENV HADOOP_VERSION 2.9.2
ENV HADOOP_URL https://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
ENV HADOOP_PREFIX /opt/hadoop-${HADOOP_VERSION}
ENV HADOOP_CONF_DIR /etc/hadoop
ENV HADOOP_HOME ${HADOOP_PREFIX}
ENV MULTIHOMED_NETWORK 1
ENV USER root
ENV PATH ${HADOOP_PREFIX}/bin:${HADOOP_PREFIX}/sbin:${PATH}

USER root

# download hadoop files
RUN set -x \
    && curl -fSL "${HADOOP_URL}" -o /tmp/hadoop.tar.gz \
    && curl -fSL "${HADOOP_URL}.asc" -o /tmp/hadoop.tar.gz.asc;\
    \
    # extract hadoop files and remove source
    tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*;\
    \
    # create symlinks, conf files and directories
    ln -s /opt/hadoop-${HADOOP_VERSION}/etc/hadoop /etc/hadoop;\
    cp /etc/hadoop/mapred-site.xml.template /etc/hadoop/mapred-site.xml;\
    mkdir -p /opt/hadoop-${HADOOP_VERSION}/logs;\
    mkdir /hadoop-data;

# configure sshd
RUN sed -i '/^#PubkeyAuthentication/ s/^#//' /etc/ssh/sshd_config; \
    sed -i '/^#PermitRootLogin/ s/^#//' /etc/ssh/sshd_config; \
    sed -i '/StrictHostKeyChecking/ s/^#//' /etc/ssh/ssh_config; \
    sed -i '/StrictHostKeyChecking/ s/ask/no/' /etc/ssh/ssh_config;\
    \
    # set permission and ownership
    chown -R ${NB_UID} ${HADOOP_PREFIX} && \
    chown -R ${NB_UID} /hadoop-data && \
    chmod 755 /hadoop-data;

USER ${NB_USER}

# copy conf files, create ssh key, exract files
RUN cp ${HOME}/hadoop_config/*.xml ${HADOOP_CONF_DIR};\
    \
    mkdir -p ${HOME}/.ssh; \
    ssh-keygen -b 2048 -t rsa -f ${HOME}/.ssh/id_rsa -q -N "";\
    cp ${HOME}/.ssh/id_rsa.pub ${HOME}/.ssh/authorized_keys;

# extract data and remove unnecessary files
RUN \
    rm ${HOME}/data/imdb/imdb.sql.gz; \
    bash -c "find ${HOME}/data/{ncdc,ngrams} -name '*.gz' -exec gunzip {};" ; \
    bash -c "rm -r ${HOME}/{hadoop_config,hive_config,binder}";

WORKDIR ${HOME}
