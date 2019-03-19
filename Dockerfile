FROM amazonlinux:2017.03.1.20170812

WORKDIR /build

ARG BUCKET_NAME
ARG VERSION

RUN \
  yum -y install yum-utils epel-release && \
  yum-config-manager --enable epel && \
  yum -y update && \
  yum -y install sudo which tar make file zip wget git libpng-devel libcurl-devel gcc python-devel libjpeg-devel && \
  curl -O https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && \
  alias sudo='sudo env PATH=$PATH' && \
  sudo pip install setuptools==39.0.1 && \
  sudo pip install virtualenv==15.2.0 && \
  git clone https://github.com/peterkuiper/serverless-image-handler.git && \
  cd serverless-image-handler/deployment && \
  ./build-s3-dist.sh $BUCKET_NAME $VERSION
