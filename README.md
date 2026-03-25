

---

32-bit FSM Based Processor

Overview

This project is a simple 32-bit processor built using a Finite State Machine (FSM) based control unit.
It executes instructions step by step across multiple clock cycles: fetch, decode, execute, and writeback.

The main goal is to understand how a CPU works internally, including instruction flow, register usage, and memory operations.

---

Key Features

* 32-bit instruction format
* FSM-based multi-cycle execution
* Separate instruction and data memory (Harvard architecture)
* 16 general-purpose registers
* Basic ALU and memory operations
* Sequential execution

---

Supported Instructions

* Arithmetic: ADD, SUB, MUL, DIV, MOD
* Logic: AND, OR, XOR, NOT
* Shift: SLL, SRL
* Comparison: SLT
* Data movement: LOAD, STORE, MOV
* Control: HALT

---

Instruction Format

[31:28] Opcode | [27:24] rd | [23:20] rs1 | [19:16] rs2 | [15:0] Immediate

---

Architecture

* Register File: 16 registers (R0 to R15)
* Program Counter (PC): tracks current instruction
* Instruction Register (IR): stores fetched instruction
* Instruction Memory: stores program
* Data Memory: used for load and store operations

---

Execution Flow

The processor works using the following FSM states:

1. IDLE – waits for start signal
2. FETCH – fetch instruction from memory
3. DECODE – decode opcode and operands
4. EXECUTE – perform operation (ALU or memory)
5. WRITEBACK – store result
6. HALT – stop execution

Each instruction takes multiple clock cycles.

---

Example Program

LOAD R0, 0
LOAD R1, 1
ADD R2, R0, R1
STORE R2, 2
MUL R3, R0, R1
HALT

---

Output

Results are stored in destination registers (for example R2, R3) or in data memory for store operations.

---

Future Work

* Add branch and jump instructions
* Add stack support (CALL/RET)
* Improve datapath and control separation
* Convert to pipelined architecture
* Build a simple assembler
  
---
