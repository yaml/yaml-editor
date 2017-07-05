FROM builder

RUN wget http://rakudo.org/downloads/star/rakudo-star-2017-04.tar.gz \
 && tar xfz rakudo-star-2017-04.tar.gz \
 && ( \
        cd rakudo-star-2017-04 \
        && perl Configure.pl --gen-moar --prefix=/perl6 \
        && make install \
    ) \
 && true

ENV PATH="/perl6/bin:/perl6/share/perl6/site/bin:${PATH}"

RUN panda update \
 && panda install YAMLish \
 && panda install Data::Dump \
 && true
