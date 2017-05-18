## -*- docker-image-name: "fundor333/hugo" -*-
FROM alpine
LABEL maintainer "fundor333@gmail.com"

# Download and install hugo
ENV HUGO_VERSION 0.20.7
ENV HUGO_DIRECTORY hugo_${HUGO_VERSION}_Linux-64bit
ENV HUGO_BINARY ${HUGO_DIRECTORY}.tar.gz

# Install HUGO
RUN set -x && \
  apk --no-cache add ca-certificates &&\
  update-ca-certificates && \
  wget https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} && \
  tar xzf ${HUGO_BINARY} && \
  rm -r ${HUGO_BINARY} && \
  mv hugo /usr/bin/hugo && \
  rm -r LICENSE.md && \
  rm -r README.md && \
  rm /var/cache/apk/* && \
  mkdir /usr/share/blog

WORKDIR /usr/share/blog
EXPOSE 1313

# Automatically build site
ONBUILD ADD site/ /usr/share/blog && RUN hugo -d /usr/share/nginx/html/

# By default, serve site
ENV HUGO_BASE_URL http://localhost:1313
CMD hugo server -b ${HUGO_BASE_URL} --bind=0.0.0.0
