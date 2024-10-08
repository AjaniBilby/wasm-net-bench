gcc -O0 ./source/native.c -o ./bin/native-opt-none
gcc -O3 ./source/native.c -o ./bin/native-opt-3
wat2wasm ./source/wasix.wat -o ./bin/wasix-opt-none.wasm
wat2wasm ./source/wasi.wat -o ./bin/wasi-opt-none.wasm