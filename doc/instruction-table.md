# Instructions

This is a preliminary documentation for the different instructions of the MCU. This document will obviously be subject to some heavy changes as the project grows (in particular when I will switch from 8 bits to 32 bits).

I will however try to keep everything as consistent as possible.

## Instruction format

| X X | X X X X X X |
| --- | --- |
| OPCode | Data Bit |

## Instruction Table

| Name | OPCode | Format | Description |
|---|---|---| --- |
| Load Const | `00` | `00DDDDDD` | takes the value from the data bits and place it in `R0` |
| Calculate | `01` | `01???PPP` | compute `R1 OP R2` and place the result in `R3`, the operator is selected by the 3 lowest bit of the data bits |
| Copy | `10` | `10SSSDDD` | Takes the value from one register and place it into another, the SRC is selected from the 3 higher bits of the data bist and the DEST is selected from the 3 lowest bits |
| Condition | `11` | `11???CCC` | Compare `R3` with `0`. if `True` is evaluated then the Program Counter jump to the address contained in `R0`. The type of condition is determined by the 3 lowest bit of the data bits |

Note that for now, all instructions execute in a single clock cycle. As such you can consider that the execution time of your program is equal to the number of instructions execute

In future versions we may use the three unused bits of the `Condition` instruction in order to actually select a register to compare against instead of just comparing with `0`

## Instructions details

### Calculate

| Operators | Code |
| --- | --- |
| `OR` | `000` |
| `NAND` | `001` |
| `NOR` | `010` |
| `AND` | `011` |
| `ADD` | `100` |
| `SUB` | `101` |

### Copy

| Register | Code |
|---|---|
| `R0` | `000` |
| `R1` | `001` |
| `R2` | `010` |
| `R3` | `011` |
| `R4` | `100` |
| `R5` | `101` |
| `R_IN` | `110` |
| `R_OUT` | `110` |

Note that `R_IN` and `R_OUT` share the same code, the chosen register depend on whether you're trying to use it as `SRC` or as `DEST`

### Condition

| Comparison | Code |
|---|---|
| `False` | `000` |
| `R3 == 0` | `001` |
| `R3 < 0` | `010` |
| `R3 <= 0` | `011` |
| `True` | `100` |
| `R3 != 0` | `101` |
| `R >= 0` | `110` |
| `R3 > 0` | `111` |

Notice that the left most bit on this tripplet act like an inversion of the four original comparison types, this can be helpful when trying to remember them.
