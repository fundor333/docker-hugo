## -*- docker-image-name: "fundor333/hugo" -*-
FROM alpine:latest
LABEL maintainer "docker@fundor333.com"

# Download and install hugo
ENV HUGO_VERSION 0.122.0

# Installing Hugo and ca-certificates
RUN set -x &&\
  apk add --no-cache --update gcompat libstdc++ wget ca-certificates &&\
  case "$(uname -m)" in \
  x86_64) ARCH=amd64 ;; \
  aarch64) ARCH=arm64 ;; \
  *) echo "hugo official release only support amd64 and arm64 now"; exit 1 ;; \
  esac && \
  HUGO_DIRECTORY="hugo_extended_${HUGO_VERSION}_linux-${ARCH}" && \
  HUGO_BINARY="${HUGO_DIRECTORY}.tar.gz" && \
  wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY} &&\
  tar xzf ${HUGO_BINARY} &&\
  rm -fr ${HUGO_BINARY} README.md LICENSE  && \
  mv hugo /usr/bin/hugo && \
  mkdir /usr/share/blog

WORKDIR /usr/share/blog
EXPOSE 1313

# Automatically build site
ONBUILD ADD site/ /usr/share/blog && RUN hugo -d /usr/share/nginx/html/

# By default, serve site
ENV HUGO_BASE_URL http://localhost:1313
CMD hugo server -b ${HUGO_BASE_URL} --bind=0.0.0.0
