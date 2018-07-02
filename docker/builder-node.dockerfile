FROM builder

RUN apt-get update \
 && apt-get install -y curl \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash \
 && apt-get install -y nodejs
