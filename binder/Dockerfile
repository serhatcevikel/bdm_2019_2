# r packages
FROM gesiscss/binder-serhatcevikel-2dbdm-5f2019-5f2-1e05af:1a7e2ee4b7c9a338eda80cd5bdeb285c71b26953
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
