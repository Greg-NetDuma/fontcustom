
FROM ubuntu:16.04

RUN apt-get update && \
    apt-get -y install ruby ruby-dev fontforge wget build-essential zlib1g-dev unzip eot-utils python git woff-tools && \
    git clone https://github.com/bramstein/sfnt2woff-zopfli.git sfnt2woff-zopfli && cd sfnt2woff-zopfli && \
    make && \
    mv sfnt2woff-zopfli /usr/local/bin/sfnt2woff && \
    git clone --recursive https://github.com/google/woff2.git && \
    cd woff2 && \
    make clean all && \
    mv woff2_compress /usr/local/bin/ && \
    mv woff2_decompress /usr/local/bin/

RUN gem install listen -v 3.1.5
RUN gem install thor
COPY . /build
WORKDIR /build
RUN gem build fontcustom.gemspec
RUN gem install --local fontcustom-2.0.0.gem

VOLUME /app/project

WORKDIR /app/project

CMD ["fontcustom", "help"]