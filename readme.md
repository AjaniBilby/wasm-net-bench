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

## Results

`wrk -t1 -cXXX -d10s http://127.0.0.1:8080`

|             |      100 |      200 |      300 |      400 |      500 |      600 |
| :-          |        -:|        -:|        -:|        -:|        -:|        -:|
| iWasm       |
| Wasmer      | 33734.78 | 34422.76 | 30700.16 | 34224.27 | 34284.26 | 33381.38 |
| NodeJS TCP  | 21844.43 | 24614.05 | 25430.37 |   626.59 |
| NodeJS HTTP | 31859.35 | 28440.95 | 32010.05 | 31063.51 | 26251.54 | 31604.09 |
| Java        | 43570.99 | 43959.95 | 40890.91 | 43831.32 | 44173.16 | 40427.46 |
| Native C    | 70517.98 | 75442.84 | 75717.62 | 75328.24 | 70658.10 | 75236.96 |
