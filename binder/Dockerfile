# r packages
FROM gesiscss/orc-binder-serhatcevikel-2dbdm-5f2019-5f2-1e05af:3b0ef24be5100b2548656f44db005c7e6cab153d
LABEL maintainer="serhatcevikel@yahoo.com"

ENV SHELL /bin/bash

# Make sure the contents of our repo are in ${HOME}
COPY ./binder ${HOME}/binder

#USER ${NB_USER}
USER root

RUN \

    ## install R kernel for jupyter
    Rscript ${HOME}/binder/rpack.R && \
    rm -r ${HOME}/binder;
 
WORKDIR ${HOME}
