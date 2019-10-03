FROM opensuse/tumbleweed
ENV PATH /root/.cargo/bin:${PATH}
RUN zypper in -t pattern -ly --force-resolution devel_C_C++
RUN zypper in -ly \
    alsa-devel \
    binutils \
    binutils-devel \
    cmake \
    curl \
    expat \
    freetype2-devel \
    gcc-c++ \
    git \
    go1.12 \
    gzip \
    jq \
    kcov \
    libcurl-devel \
    libdw-devel \
    libelf-devel \
    libexpat-devel \
    libopenssl-devel \
    libxcb-devel \
    openssh \
    postgresql-devel \
    python \
    wget
RUN go get -u github.com/cloudflare/cfssl/cmd/...
RUN ln -s /root/go/bin/* /bin/
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup component add clippy rustfmt && \
    rustup target add \
        wasm32-unknown-unknown \
        wasm32-unknown-emscripten \
        asmjs-unknown-emscripten
RUN cargo install \
    cargo-edit \
    cargo-kcov \
    cargo-update \
    cargo-web
RUN cargo install diesel_cli --no-default-features --features postgres
