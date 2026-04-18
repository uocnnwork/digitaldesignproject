# 8-bit Single-Cycle ARM Microprocessor 🧠

## 📌 Project Overview
A complete hardware implementation of an 8-bit single-cycle microprocessor based on the ARM Instruction Set Architecture (ISA). Developed entirely in SystemVerilog, this project features a fully functional datapath and control logic. The design is highly modular and has been rigorously validated through comprehensive unit and top-level integration testbenches using simulation waveforms.

## 🚀 Key Features
* **Single-Cycle Execution:** Executes each instruction in a single clock cycle, demonstrating efficient control unit and datapath synchronization.
* **Modular Datapath Design:** Independently designed RTL core components including the ALU, Register File, Program Counter, and Memory blocks.
* **Robust Verification:** Extensive testbench suite covering both individual unit testing for every module and full top-level integration validation.

## 📂 Repository Structure

```text
.
├── src/                                  # RTL Source Code
│   ├── alu.sv                            # Arithmetic Logic Unit
│   ├── control_unit.sv                   # Main Control Unit
│   ├── data_memory.sv                    # Data Memory (RAM)
│   ├── instruction_memory.sv             # Instruction Memory (ROM)
│   ├── program_counter.sv                # Program Counter (PC)
│   ├── register_file.sv                  # Register File
│   ├── retro_processor.sv                # Top-level Microprocessor Module
│   └── retro_processor_pkg.sv            # SystemVerilog Package definitions
└── tb/                                   # Testbenches for Verification
    ├── alu_unit_tb.sv                    # ALU unit test
    ├── control_unit_unit_tb.sv           # Control unit test
    ├── data_memory_unit_tb.sv            # Data memory unit test
    ├── instruction_memory_unit_tb.sv     # Instruction memory unit test
    ├── program_counter_unit_tb.sv        # PC unit test
    ├── register_file_unit_tb.sv          # Register file unit test
    ├── retro_processor_integration_tb.sv # Top-level integration test
    └── retro_processor_tb_pkg.sv         # Testbench Package definitions
