FROM yamlio/builder

RUN wget http://rakudo.org/downloads/star/rakudo-star-2016.11.tar.gz \
 && tar xfz rakudo-star-2016.11.tar.gz \
 && ( \
        cd rakudo-star-2016.11 \
        && perl Configure.pl --gen-moar --prefix=/perl6 \
        && make install \
    ) \
 && true

ENV PATH="/perl6/bin:/perl6/share/perl6/site/bin:${PATH}"

RUN panda update \
 && panda install YAMLish \
 && panda install Data::Dump \
 && true
