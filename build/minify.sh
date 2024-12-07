#!/bin/bash
# Get value of the variable containing base64 encoded wasm file
# store it in `jswasm/tmp/input.txt`
mkdir -p jswasm/tmp
grep "var f = 'data:application/octet-stream;base64," 'jswasm/sqlite3.js' \
    | cut -f2 -d ',' \
    | cut -f1 -d "'"  \
    | tr -d '\n' \
    > 'jswasm/tmp/input.txt'

# decode base64 to wasm for wasm-strip
base64 -d 'jswasm/tmp/input.txt' > 'jswasm/tmp/sqlite3.wasm' \

# minify wasm file using wasm-strip
wasm-strip 'jswasm/tmp/sqlite3.wasm'

# encode wasm back to base64. 
cat 'jswasm/tmp/sqlite3.wasm' | base64 -w 0 > 'jswasm/tmp/output.txt'

# replace the wasm file 
node minify.mjs
rm -fr jswasm/tmp
