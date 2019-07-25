# the base miniconda3 image
FROM continuumio/miniconda3:latest

ENV DATA_DIR=/data
ENV CODE_DIR=/code
ENV APP_DIR=/ide-app

RUN mkdir -p "$APP_DIR"

WORKDIR "$APP_DIR"

RUN mkdir -p "$DATA_DIR"
RUN mkdir -p "$CODE_DIR"

# load in the environment.yml file - this file controls what Python packages we install
ADD environment.yml "$APP_DIR"

# install the Python packages we specified into the base environment
RUN conda update -n base conda -y && conda env update

# download the coder binary, untar it, and allow it to be executed
RUN wget https://github.com/codercom/code-server/releases/download/1.408-vsc1.32.0/code-server1.408-vsc1.32.0-linux-x64.tar.gz \
    && tar -xzvf code-server1.408-vsc1.32.0-linux-x64.tar.gz && chmod +x code-server1.408-vsc1.32.0-linux-x64/code-server

COPY docker-entrypoint.sh /usr/local/bin/



VOLUME ["$(pwd)/data:$DATA_DIR", "$(pwd)/code:$CODE_DIR"]

ENTRYPOINT ["docker-entrypoint.sh"]