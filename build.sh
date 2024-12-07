#!/bin/bash
# Clean previous outputs
sudo rm -fr output/* -fr
# Build sqlite3.js
sudo docker build -t builder .

# Copy build outputs from container to local filesystem
sudo docker run --rm -v "$PWD/output/:/build/output/" -it builder bash -c 'cp /build/sqlite/ext/wasm/jswasm/* /build/output/'

