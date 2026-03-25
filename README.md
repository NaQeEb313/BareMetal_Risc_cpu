

```md
## 32-bit FSM Based Processor

### About

A simple 32-bit processor designed using a Finite State Machine (FSM) based control unit.  
The processor executes instructions in multiple cycles: fetch, decode, execute, and writeback.

This project is made to understand low level CPU working like instruction execution, register operations, and memory access.

---

### Features

- 32-bit custom instruction format  
- Multi-cycle execution (FSM controlled)  
- Separate instruction and data memory  

- Basic instruction set:
  - LOAD  
  - STORE  
  - ADD  
  - SUB  
  - AND  
  - OR  
  - XOR  
  - MUL  
  - DIV  
  - MOD  
  - SLT  
  - SHIFT (left/right)  
  - NOT  
  - MOV  
  - HALT  

- 16 general-purpose registers  
- Sequential execution  

---

### Instruction Format

```

[31:28] Opcode | [27:24] rd | [23:20] rs1 | [19:16] rs2 | [15:0] Immediate

```

---

### Registers

- reg_file[0:15] → general purpose registers  
- pc → program counter  
- instr → instruction register  

---

### Memory

- memory → instruction memory  
- data_mem → data memory  

---

### Working

The processor works using FSM states:

- IDLE → waits for start  
- FETCH → fetch instruction from memory  
- DECODE → decode instruction fields  
- EXECUTE → perform ALU or memory operation  
- WRITEBACK → write result to register or memory  
- HALT → stop execution  

Each instruction takes multiple clock cycles.

---

### Example Program

```

LOAD R0, 0
LOAD R1, 1
ADD R2, R0, R1
STORE R2, 2
MUL R3, R0, R1
HALT

```

---

### Output

Result is stored in destination registers (example: R2, R3).

---

### Future Improvements

- Add branch instructions  
- Add stack support (CALL/RET)  
- Improve datapath design  
- Convert to pipelined CPU  
- Build assembler for instruction input  
```
