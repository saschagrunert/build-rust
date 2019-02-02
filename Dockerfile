FROM opensuse/tumbleweed
ENV PATH /root/.cargo/bin:${PATH}
COPY assets/kcov-system-daemon /bin
RUN zypper in -t pattern -ly devel_C_C++
RUN zypper in -ly \
    alsa-devel \
    cmake \
    curl \
    expat \
    freetype2-devel \
    gcc-c++ \
    git \
    libexpat-devel \
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
RUN cargo install diesel_cli --no-default-features --features postgres
