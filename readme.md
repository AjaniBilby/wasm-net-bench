# Wasm Net Bench

Is the most slim-lined of possible http networking benchmarks.
The purpose of this benchmark isn't to test the processing speed of the wasm runtime, but instead to gauge the overheads of it's networking stack.

This benchmark simply listens for incoming connections on a **single** thread, upon connection it immediately sends back a static http payload, closes the connection and waits for the next.

Using only blocking calls on a single thread is to help ensure maximum impact of any slow sys-calls.

## Requirements

 - [iWasm](https://github.com/bytecodealliance/wasm-micro-runtime/releases)
 - [Wabt](https://github.com/WebAssembly/wabt)'s `wat2wasm` 
 - [Wasmer](https://docs.wasmer.io/install)
 - [Wrk](https://github.com/wg/wrk)
 - gcc

## Usage

```bash
./build.bash
./benchmark.bash
```