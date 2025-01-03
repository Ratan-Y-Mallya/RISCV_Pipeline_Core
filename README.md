# RISC-V 5 stage  Pipelined Core (Derived from Single-Cycle Core)

---

## Project Overview
This project implements a pipelined RISC-V processor based on the RV32I instruction set architecture. Starting from a single-cycle RISC-V processor, the design has been enhanced to include a pipelined architecture, improving overall performance by executing multiple instructions simultaneously in different stages of the pipeline.

![image](https://github.com/user-attachments/assets/ad883ea0-c513-4493-84ac-79a27da6dc4c)


---

## Features
1. **Instruction Set Support:**
   - Supports the RV32I base instruction set, including arithmetic, logical, memory access, and branching instructions.
   
2. **Pipeline Stages:**
   - **Instruction Fetch (IF):** Fetches the instruction from memory.
   - **Instruction Decode (ID):** Decodes the instruction and reads register values.
   - **Execute (EX):** Performs arithmetic, logical operations, and calculates memory addresses.
   - **Memory Access (MEM):** Reads/writes data from/to memory.
   - **Write-Back (WB):** Writes results back to registers.

3. **Hazard Handling:**
   - Data hazards resolved using forwarding logic.
   - Structural hazards avoided through careful design of memory interfaces.
   - Control hazards minimized using branch prediction and flush mechanisms.

4. **Performance Improvements:**
   - Increased instruction throughput via pipelining.
   - Stalling and hazard mitigation to handle dependencies efficiently.

 5. Scalability
   - Modular design enables easy extension to support additional features, such as:
   - Floating-point operations.
   - RV32M instruction set (multiplication and division).
   - Interrupt handling.


## 🧪 Testing
### Unit Testing
Each module (e.g., ALU, control unit, hazard unit) is individually verified with test cases.

### Integration Testing
Full pipeline functionality is validated using a suite of RISC-V assembly programs.

### Performance Evaluation
Compared the clock cycles per instruction (CPI) of the pipelined processor with the single-cycle implementation.



## 🔮 Future Enhancements
* Add support for RV32M instructions (multiplication and division).
* Implement advanced branch prediction for efficient control hazard resolution.
* Introduce instruction and data caches for faster memory access.
* Extend support to RV64I for 64-bit processing.

## RTL Analysis

![image](https://github.com/user-attachments/assets/637f22aa-a85d-44ce-8ca5-23a4cefc4d1d)


![image](https://github.com/user-attachments/assets/7ecaefd5-d314-477d-9184-6efe48582838)



