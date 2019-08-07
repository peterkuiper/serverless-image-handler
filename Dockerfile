FROM amazonlinux:2018.03

WORKDIR /build

ARG BUCKET_NAME
ARG VERSION

RUN \
  set -eux; \
  yum -y install yum-utils epel-release; \
  yum-config-manager --enable epel; \
  yum -y update; \
  yum -y install \
    diffutils \
    file \
    gcc \
    git \
    libcurl-devel \
    libjpeg-devel  \
    libpng-devel \
    make \
    openssl-devel \
    python-devel \
    python27-devel \
    sudo \
    tar \
    wget \
    which \
    zip \
  ; \
  curl -O https://bootstrap.pypa.io/get-pip.py; \
  python get-pip.py; \
  alias sudo='sudo env PATH=$PATH'; \
  sudo /usr/local/bin/pip install setuptools==39.0.1; \
  sudo /usr/local/bin/pip install virtualenv==15.2.0; \
  git clone https://github.com/peterkuiper/serverless-image-handler.git; \
  cd serverless-image-handler/deployment; \
  ./build-s3-dist.sh $BUCKET_NAME $VERSION
