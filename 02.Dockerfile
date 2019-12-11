# install mongo package
# pip packages, node, tldr, q, beaker
# jupyter, tldr cache, .bashrc, pgcli, expect for parallel
FROM gesiscss/orc-binder-serhatcevikel-2dbdm-5f2019-5f2-1e05af:1e72427e38c163ded97a222faeb3e677bbf494c4

LABEL maintainer="serhatcevikel@yahoo.com"

USER root

RUN \
    # install mongo
    # https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/
    #wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add - && \
    #echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list && \
    echo "deb http://deb.debian.org/debian/ stretch main" | sudo tee /etc/apt/sources.list.d/debian-stretch.list && \
    apt update && \
    apt install -y \
        libv8-3.14-dev \
        mongodb; \
    # libcurl3 installation removes r, curl and libcurl4
    # mongodb installation comes from stretch

RUN \
    # install pip packages
    pip3 install --no-cache \
        bash_kernel \
        beakerx \
        imongo-kernel \
        ipython_mongo \
        ipython-sql \
        jupyter_contrib_nbextensions \
        jupyter-nbextensions-configurator \
        nbpresent \
        notebook \
        pgcli \
        pgspecial \
        postgres_kernel \
        py4j \
        quilt==2.9.15 \
        RISE \
        sos \
        sos-notebook; \

    # install node
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \
        apt install -y nodejs build-essential; \

    # tldr
    npm install tldr -g; \
    
    # install q 
    qdeblink=$(lynx -listonly -nonumbers -dump "https://github.com/harelba/q/releases" | grep -P "\.deb$" | head -1); \
    qdebfile=${qdeblink##*/}; \

    wget -P ${HOME} $qdeblink && \
    dpkg -i ${HOME}/$qdebfile && \
    rm ${HOME}/$qdebfile; \

    ## install beaker kernels
    beakerx install; \

# create jovyan user
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY ./binder ${HOME}/binder

USER root

RUN \
    # own home directory by user
    chown -R ${NB_UID} ${HOME}

USER ${NB_USER}

RUN ls ${HOME};

RUN ls ${HOME}/binder;

# nbpresent
RUN python3 -m bash_kernel.install; \
    python3 -m sos_notebook.install; \
    jupyter contrib nbextension install --user; \
    jupyter nbextensions_configurator enable --user; \
    jupyter nbextension install nbpresent --py --overwrite --user; \
    jupyter nbextension enable nbpresent --py --user; \
    jupyter serverextension enable nbpresent --py --user; \
    jupyter-nbextension enable codefolding/main --user; \
    jupyter-nbextension install rise --py --user; \
    jupyter-nbextension enable splitcell/splitcell --user; \
    jupyter-nbextension enable hide_input/main --user; \
    jupyter-nbextension enable nbextensions_configurator/tree_tab/main --user; \
    jupyter-nbextension enable nbextensions_configurator/config_menu/main --user; \
    jupyter-nbextension enable contrib_nbextensions_help_item/main  --user; \
    jupyter-nbextension enable scroll_down/main --user; \
    jupyter-nbextension enable toc2/main --user; \
    jupyter-nbextension enable autoscroll/main  --user; \
    jupyter-nbextension enable rubberband/main --user; \
    jupyter-nbextension enable exercise2/main --user; \
    cp $HOME/binder/common.json $HOME/.jupyter/nbconfig/common.json; \

    # update tldr cache
    tldr -u; \
    
    # screenrc
    printf "hardstatus on\nhardstatus alwayslastline\nhardstatus string \"%%w\"\n" >> ${HOME}/.screenrc; \
    
    # bashrc
    echo "export JAVA_HOME=/usr/lib/jvm/default-java" >> $HOME/.bashrc; \
    echo "export LC_ALL=C.UTF-8" >> $HOME/.bashrc; \
    echo "export LANG=C.UTF-8" >> $HOME/.bashrc; \
    echo "export EDITOR=vim" >> $HOME/.bashrc; \
    #echo "[[ \$TERM != \"screen\" ]] && exec screen -q" >> ${HOME}/.bashrc; \

    ## pgcli default options
    mkdir -p $HOME/.config/pgcli; \
    cp $HOME/binder/pgcli_config $HOME/.config/pgcli/config; \

    # run expect script for parallel
    expect ${HOME}/binder/expect_script; \
    
    # remove files
    rm -r ${HOME}/binder;
