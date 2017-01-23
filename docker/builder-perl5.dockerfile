FROM builder

RUN apt-get install -y \
        cpanminus \
        perl

RUN cpanm -n Zilla::Dist
RUN cpanm -n \
        Spiffy \
 && true
