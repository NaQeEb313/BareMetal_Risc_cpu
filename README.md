
---

## **8-bit FSM Based Processor**

### **About**

A simple 8-bit processor designed using a Finite State Machine (FSM) based control unit.
The processor executes instructions in multiple cycles, following the classic stages: fetch, decode, execute, and writeback.

This project was built to understand how a CPU operates at a low level, including instruction handling, control flow, and register operations.

---

### **Features**

* 8-bit custom instruction format
* Multi-cycle execution (FSM controlled)
* Basic instruction set:

  * LOAD
  * ADD
  * SUB
  * HALT
* Two general-purpose registers (A, B)
* Sequential instruction execution
* Simple control unit design

---

### **Instruction Format**

```
[7:6] Opcode | [5:4] Destination | [3:0] Immediate
```

**Example:**

```
00_00_0101 → LOAD A, 5
```

---

### **Registers**

* `reg_A` → primary accumulator (stores final results)
* `reg_B` → secondary register
* `pc` → program counter
* `instr` → instruction register

---

### **Working**

The processor operates through the following FSM states:

* **IDLE** → waits for start signal
* **FETCH** → reads instruction from memory
* **DECODE** → interprets opcode and operands
* **EXECUTE** → performs the operation
* **WRITEBACK** → stores result in register
* **HALT** → stops execution

Each instruction is executed over multiple clock cycles, making the design simple and easy to understand.

---

### **Example Program**

```
LOAD A, 5
LOAD B, 3
ADD A, B
SUB A, B
HALT
```

---

### **Output**

The final result is stored in register `A`.

---

### **Future Improvements**

* Expand instruction set
* Add more registers
* Design a proper datapath + control separation
* Upgrade to pipelined architecture
* Build a simple assembler

---



