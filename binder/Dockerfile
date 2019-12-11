# nosql
FROM gesiscss/orc-binder-serhatcevikel-2dbdm-5f2019-5f2-1e05af:45d8e15f8197c8565390b14b50a809ca12bb0541
LABEL maintainer="serhatcevikel@yahoo.com"

USER root

RUN \
    # install xidel
    wget "https://netcologne.dl.sourceforge.net/project/videlibri/Xidel/Xidel%200.9.8/xidel_0.9.8-1_amd64.deb" && \
    dpkg -i xidel_0.9.8-1_amd64.deb && \
    rm xidel_0.9.8-1_amd64.deb;\
    
    # install IRkernel
    Rscript -e "IRkernel::installspec(user = FALSE)";

USER ${NB_USER}

RUN \
    # extract comtrade files
    datadir=$HOME/data; \
    comtradedir=$datadir/comtrade_s1; \
    
    mkdir -p $comtradedir/2010e; \
    
    find $comtradedir/2010 -mindepth 1 | \
    parallel -k -j0 "basenm=\$(basename {}); gunzip -c {} > ${comtradedir}/2010e/\${basenm%.gz};";

WORKDIR ${HOME}
