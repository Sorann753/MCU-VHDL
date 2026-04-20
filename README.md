# MCU-VHDL

This is a small project where i implement my own custom 8 bit micro-controller into VHDL

## Inspiration

I first played the game `Turing-Complete` a couple years ago and i did reach the turing complete 8 bit computer level. Then i had forgotten about the game (mainly because i couldn't code in assembly at all)

Then in march 2026 i started learning VHDL and i really love this language, so i decided why not recreate that mini computer into VHDL and here we are.

## Goals

[X] For now i'm just going to recreate a 1 to 1 version of the machine that i had made in the game (as bad as it may be).

[ ] After that, once it's working in test benches, i'll make my own custom Assembler and Bootloader in order to be able to program it once it's onto an actual FPGA.

[ ] Then later i will probably extend the code to turn it into a 16bit or 32bit machine depending on how hard this will actually be in VHDL.

[ ] Then once i'm done i'll probably start implementing a bunch of the standard stuff you'd expect from a computer onto my architecture like a Stack, better branching, floating points and we'll see how it goes from there.

[ ] Also at some point i would really love to create an actual C compiler for my micro-controller, but i'm pretty sure that this will be quite complex so i'll just be keeping that in the back of my head for now.

## Compiling

For now i run this all on the simulator `GHDL` so you'll need to install that.
Once you're done, you can just run my **very** simple bash script `RunTest.sh` to generate all the `.ghw` files.
Then you can visualize everything in your favorite signal analyzer software, i personally use GTKwave.

This project should be able to be deployed on any FPGA, but i haven't done it yet because i don't own any, i'll be updating this description once i got one.

## Contributing

Contributions are always apreciated, however note that this is more of a learning repo than anything super serious. So if you guys see anything outrageous and want to make a pull request to fix it, please make sure you include a clear explanation for why this is better since i'm still a beginer in all this.

For now i'll only be using VHDL and not Verilog or SystemVerilog. i might be using SystemVerilog for test benches if they ever become really complicated in the future, but since the open source ecosystem doesn't really handle the `VHDL + SystemVerilog` stack well i'd rather avoid it for now.
