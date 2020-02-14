# quiltdata 
# postgres config
FROM gesiscss/binder-serhatcevikel-2dbdm-5f2019-5f2-1e05af:6fc5e73b94b194c9670f32e6cf734f2792138c98
LABEL maintainer="serhatcevikel@yahoo.com"

# environment variables
ENV CLASSPATH ${JAVA_HOME}/lib/postgresql-42.2.8.jar
ENV PATH ${PATH}:/usr/lib/postgresql/11/bin

USER ${NB_USER}

RUN \
    # quilt
    quilt install serhatcevikel/bdm_data; \
    quilt export serhatcevikel/bdm_data ${HOME}/data;

USER root

RUN \
    #jdbc for postgresql
    wget -P /usr/lib/jvm/default-java/lib https://jdbc.postgresql.org/download/postgresql-42.2.8.jar; \
    # java env variables 
    \
    # add postgresql bin dir to path
    \
    # change postgres password
    echo "postgres:postgres" | chpasswd; \
    \
    # pg config
    perl -i -pe 's/(md5|peer)$/trust/g' /etc/postgresql/11/main/pg_hba.conf;

USER ${NB_USER}

RUN \
    # extract tsv files onto tsv2
    datadir=${HOME}/data; \
    imdbdir=${datadir}/imdb; \
    \
    mkdir -p ${imdbdir}/tsv2; \
    \
    find ${imdbdir}/tsv -mindepth 1 | \
    parallel -k -j0 "basenm=\$(basename {}); gunzip -c {} > ${imdbdir}/tsv2/\${basenm%.gz};";

# start postgresql and create imdb database
USER postgres
RUN /usr/lib/postgresql/11/bin/pg_ctl start -D /etc/postgresql/11/main/ -m smart && \
    createdb -U postgres imdb2 && \
    gunzip -c ${HOME}/data/imdb/imdb.sql.gz | psql imdb2 postgres && \
    /usr/lib/postgresql/11/bin/pg_ctl stop -D /etc/postgresql/11/main/ -m smart;

USER ${NB_USER}
WORKDIR ${HOME}
