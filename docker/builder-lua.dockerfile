FROM builder

RUN apt-get install -y \
        luajit \
        libluajit-5.1-dev \
 && ( \
    cd / \
    && wget https://luarocks.org/releases/luarocks-2.4.1.tar.gz \
    && tar zxpf luarocks-2.4.1.tar.gz \
    && cd luarocks-2.4.1 \
    && ./configure \
            --lua-suffix=jit \
            --with-lua=/usr \
            --with-lua-include=/usr/include/luajit-2.0 \
    && make build \
    && make install \
 ) \
 && true
