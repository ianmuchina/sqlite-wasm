import fs from 'node:fs'

const wasmLarge = fs.readFileSync('jswasm/tmp/input.txt').toString()
const wasmSmall = fs.readFileSync('jswasm/tmp/output.txt').toString()
const jsSource = fs.readFileSync('jswasm/sqlite3.js').toString()

const newSource = jsSource.replace(wasmLarge, wasmSmall)

fs.writeFileSync('jswasm/sqlite3.js', newSource)

