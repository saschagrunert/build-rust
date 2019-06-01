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
    gzip \
    jq \
    libcurl-devel \
    libexpat-devel \
    libelf-devel \
    libdw-devel \
    libopenssl-devel \
    libxcb-devel \
    openssh \
    postgresql-devel \
    python \
    wget
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
RUN cargo kcov --print-install-kcov-sh | sh
RUN cargo install diesel_cli --no-default-features --features postgres
