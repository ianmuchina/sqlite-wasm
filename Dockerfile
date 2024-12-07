FROM debian:bookworm
SHELL ["/bin/bash", "-c"]

# Install debian dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates git nodejs bash python3 tcl build-essential wabt coreutils grep && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Clone Git repos
WORKDIR /build
RUN git clone --depth=1 https://github.com/emscripten-core/emsdk.git && \
    git clone --depth=1 https://github.com/sqlite/sqlite.git

# Install emscripten sdk
WORKDIR /build/emsdk/
RUN ./emsdk install latest && ./emsdk activate latest

# Apply sqlite patch
WORKDIR /build/sqlite/
COPY build/0001-sSINGLE_FILE.patch /build/0001-sSINGLE_FILE.patch
RUN git apply /build/0001-sSINGLE_FILE.patch

# Compile sqlite.c
RUN source /build/emsdk/emsdk_env.sh && \
    ./configure --enable-all && \
    make sqlite3.c -release

# Compile sqlite-wasm
WORKDIR /build/sqlite/ext/wasm
RUN make o2 barebones=1 || true

# Minify sqlite wasm
COPY build/minify.* /build/sqlite/ext/wasm/
RUN ./minify.sh
