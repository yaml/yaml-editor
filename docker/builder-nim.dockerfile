FROM builder

ENV PATH=/nim-0.16.0/bin:$PATH

RUN wget http://nim-lang.org/download/nim-0.16.0.tar.xz \
 && tar xJf nim-0.16.0.tar.xz \
 && ( \
        cd nim-0.16.0 \
        && sh build.sh \
        && nim c koch \
        && ./koch tools \
    ) \
 && true
