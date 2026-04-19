#!/bin/bash
set -e;

echo "=== SIMULATING VHDL ===";

echo "=== STARTING ALL TEST BENCH ===";

echo "[TESTING] - Program Counter";
ghdl -a --std=08 ./components/ProgramCounter.vhd ./test/unit-test/ProgramCounter_TB.vhd;
ghdl -e --std=08 ProgramCounter_TB;
echo "[INFO] - build complete";
echo "[INFO] - starting simulation";
ghdl -r --std=08 ProgramCounter_TB --wave=./test/measures/PC.ghw --stop-time=170us
echo "[SUCCESS] - simulation complete";

echo "[TESTING] - Register";
ghdl -a --std=08 ./components/Register.vhd ./test/unit-test/Register_TB.vhd;
ghdl -e --std=08 RegisterPlus_TB;
echo "[INFO] - build complete";
echo "[INFO] - starting simulation";
ghdl -r --std=08 RegisterPlus_TB --wave=./test/measures/Register.ghw --stop-time=100us
echo "[SUCCESS] - simulation complete";

echo "[TESTING] - 3bit Decoder";
ghdl -a --std=08 ./components/Decoder3bit.vhd ./test/unit-test/Decoder3bit_TB.vhd;
ghdl -e --std=08 Decoder3bit_TB;
echo "[INFO] - build complete";
echo "[INFO] - starting simulation";
ghdl -r --std=08 Decoder3bit_TB --wave=./test/measures/Decoder3bit.ghw --stop-time=120us
echo "[SUCCESS] - simulation complete";

echo "[TESTING] - Opcode decoder";
ghdl -a --std=08 ./components/OpcodeDecoder.vhd ./test/unit-test/OpcodeDecoder_TB.vhd;
ghdl -e --std=08 OpcodeDecoder_TB;
echo "[INFO] - build complete";
echo "[INFO] - starting simulation";
ghdl -r --std=08 OpcodeDecoder_TB --wave=./test/measures/OpcodeDecoder.ghw --stop-time=1330us
echo "[SUCCESS] - simulation complete";

echo "[TESTING] - Boolean Unit";
ghdl -a --std=08 ./components/BooleanUnit.vhd ./test/unit-test/BooleanUnit_TB.vhd;
ghdl -e --std=08 BooleanUnit_TB;
echo "[INFO] - build complete";
echo "[INFO] - starting simulation";
ghdl -r --std=08 BooleanUnit_TB --wave=./test/measures/BooleanUnit.ghw --stop-time=115us
echo "[SUCCESS] - simulation complete";

echo "[TESTING] - ALU";
ghdl -a --std=08 ./components/ALU.vhd ./test/unit-test/ALU_TB.vhd;
ghdl -e --std=08 ALU_TB;
echo "[INFO] - build complete";
echo "[INFO] - starting simulation";
ghdl -r --std=08 ALU_TB --wave=./test/measures/ALU.ghw --stop-time=115us
echo "[SUCCESS] - simulation complete";

echo "[TESTING] - Full MCU";
ghdl -a --std=08 ./MCU.vhd ./test/integration-test/MCU_TB.vhd;
ghdl -e --std=08 MCU8b_TB;
echo "[INFO] - build complete";
echo "[INFO] - starting simulation";
ghdl -r --std=08 MCU8b_TB --wave=./test/measures/MCU.ghw --stop-time=310us
echo "[SUCCESS] - simulation complete";

echo "[SUCCESS] - all test bench have been simulated";
