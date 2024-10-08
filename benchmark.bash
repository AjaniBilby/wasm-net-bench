echo ""
echo ""
echo "Native"
./measure.bash "./bin/native-opt-none"
sleep 1

echo ""
echo ""
echo "Native Optimised"
./measure.bash "./bin/native-opt-3"
sleep 1

echo ""
echo ""
echo "Wasmer"
./measure.bash "wasmer run --llvm --net ./bin/wasix-opt-none.wasm"
sleep 1


echo ""
echo ""
echo "iWasm"
# ./measure.bash "iwasm --addr-pool=0.0.0.0/0 ./bin/wasi-opt-none.wasm"
sleep 1
echo "disabled"