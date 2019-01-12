FROM archlinux/base:latest
ENV PATH /root/.cargo/bin:${PATH}
RUN pacman --noconfirm -Sy \
    alsa-lib \
    base-devel \
    cmake \
    curl \
    freetype2 \
    git \
    kcov \
    openssh \
    postgresql-libs \
    python \
    vulkan-headers \
    vulkan-tools \
    vulkan-validation-layers \
    wget
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN rustup toolchain add beta && \
    rustup default nightly && \
    rustup component add \
        clippy-preview \
        rls-preview \
        rust-analysis \
        rustfmt-preview && \
    rustup target add \
        --toolchain nightly \
        wasm32-unknown-unknown \
        wasm32-unknown-emscripten \
        asmjs-unknown-emscripten
RUN cargo install \
    cargo-edit \
    cargo-kcov \
    cargo-update \
    cargo-web
RUN cargo install diesel_cli --no-default-features --features postgres
