# r packages
FROM gesiscss/orc-binder-serhatcevikel-2dbdm-5f2019-5f2-1e05af:bf4d5846fc0ae09ae58e5c5b678ccd7179b63eb7
LABEL maintainer="serhatcevikel@yahoo.com"

# Make sure the contents of our repo are in ${HOME}
COPY ./binder ${HOME}/binder

#USER ${NB_USER}
USER root

RUN \
    ## install R kernel for jupyter
    Rscript ${HOME}/binder/rpack.R && \
    rm -r ${HOME}/binder;
 
USER ${NB_USER}
WORKDIR ${HOME}
