#!/bin/bash

echo "=== SIMULATING VHDL ===";

echo "=== STARTING ALL TEST BENCH ===";

echo "[TESTING] - Program Counter";
ghdl -a --std=08 ./components/ProgramCounter.vhd ./test/ProgramCounter_TB.vhd;
ghdl -e --std=08 ProgramCounter_TB;
echo "[INFO] - build complete";
echo "[INFO] - starting simulation";
ghdl -r --std=08 ProgramCounter_TB --wave=./test/measures/PC.ghw --stop-time=170us
echo "[SUCCESS] - simulation complete";

echo "[TESTING] - Register";
ghdl -a --std=08 ./components/Register.vhd ./test/Register_TB.vhd;
ghdl -e --std=08 RegisterPlus_TB;
echo "[INFO] - build complete";
echo "[INFO] - starting simulation";
ghdl -r --std=08 RegisterPlus_TB --wave=./test/measures/Register.ghw --stop-time=100us
echo "[SUCCESS] - simulation complete";

echo "[TESTING] - 3bit Decoder";
ghdl -a --std=08 ./components/Decoder3bit.vhd ./test/Decoder3bit_TB.vhd;
ghdl -e --std=08 Decoder3bit_TB;
echo "[INFO] - build complete";
echo "[INFO] - starting simulation";
ghdl -r --std=08 Decoder3bit_TB --wave=./test/measures/Decoder3bit.ghw --stop-time=120us
echo "[SUCCESS] - simulation complete";

echo "[SUCCESS] - all test bench have been simulated";
