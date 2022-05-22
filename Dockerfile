FROM gittools/gitversion:5.6.6

COPY ./version-extractor.sh /repo/

RUN apt-get -y update && \ 
  apt-get install -y -qq curl jq && \
  export PATH=$PATH:/usr/local/bin:/tools && \
  chmod +x /repo/version-extractor.sh

ONBUILD COPY ./.git/. /repo/.git/
ONBUILD COPY ./GitVersion.yml /repo/GitVersion.yml

ONBUILD WORKDIR /repo
ONBUILD RUN exec sh version-extractor.sh