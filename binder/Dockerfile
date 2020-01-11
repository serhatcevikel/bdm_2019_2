# r packages
FROM gesiscss/binder-serhatcevikel-2dbdm-5f2019-5f2-1e05af:aea2c9dc866aa56cae95822b96f761f577cf0fdf
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
