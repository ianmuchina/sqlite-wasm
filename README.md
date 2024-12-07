# sqlite-wasm

[![Release](https://github.com/ianmuchina/sqlite-wasm/actions/workflows/release.yaml/badge.svg)](https://github.com/ianmuchina/sqlite-wasm/actions/workflows/release.yaml)

Nightly builds of
[sqlite-wasm](https://github.com/sqlite/sqlite/blob/master/ext/wasm/README.md)

Uses [emscripten](https://sqlite.org/wasm/doc/trunk/emscripten.md) with
[`-sSINGLE_FILE=1`](https://emscripten.org/docs/tools_reference/settings_reference.html#single-file).
Outputs a self contained `sqlite3.js` file.

The file is then minified with the [build/minify.sh](build/minify.sh) script.
Uses [`wasm-strip`](https://webassembly.github.io/wabt/doc/wasm-strip.1.html)

Useful in environments that can't load wasm files due to CORS restrictions eg:
`file://`

## Files

- `sqlite3.js` - js file with comments `2MiB`
- `sqlite3.min.js` - js file without comments `1.6MiB`

After compression the files are around the same size

## Usage

[`build.sh`](./build.sh) or
[`.github/workflows/release.yaml`](.github/workflows/release.yaml)
