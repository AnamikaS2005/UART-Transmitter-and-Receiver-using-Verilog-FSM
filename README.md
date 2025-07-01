# UART Transmitter and Receiver in Verilog

> 🚀 A simulation-based UART protocol implementation using Verilog. Includes a UART transmitter and receiver designed with FSM logic, bit-wise serialization, and parity checking. Testbenches validate correctness.

---

## 📚 Overview

This project demonstrates the design and simulation of a **Universal Asynchronous Receiver/Transmitter (UART)** using **Verilog HDL**. The modules support:

- **8-bit data transfer**
- **Start, stop, and parity bits**
- **Serial-to-parallel and parallel-to-serial communication**
- FSM-based control and timing
- Synthesis-ready and testbench-driven verification

> This UART project mimics real-world communication behavior and is designed for simulation on platforms like **ModelSim**, **Vivado**, or **Icarus Verilog**.

---

## 🧠 UART Frame Format Used

| Field       | Bits | Description         |
|-------------|------|---------------------|
| Start Bit   | 1    | Always `0`          |
| Data Bits   | 8    | MSB-to-LSB or LSB-to-MSB (here LSB first) |
| Parity Bit  | 1    | Even parity         |
| Stop Bits   | 2    | Always `11`         |
| **Total**   | 12   |                    |

---

## 📂 File Structure

| File | Description |
|------|-------------|
| `src/uart_trans.v`  | UART Transmitter RTL |
| `src/uart_recv.v`   | UART Receiver RTL |
| `tb/tb_uart_trans.v` | Testbench for transmitter |
| `tb/tb_uart_recv.v`  | Testbench for receiver |
| `waveform/*.png`    | Simulation results (optional screenshots) |

---

## 🔧 Transmitter (uart_trans.v)

- Parallel 8-bit input (`din`)
- Frames with start, parity, and stop bits
- Serializes into 12-bit frame using shift register
- FSM manages timing (bit intervals)

### Key Signals:
- `ee`: Enable transmission
- `eo`: Serial output
- `p`: Even parity (`~^din`)

---

## 🔧 Receiver (uart_recv.v)

- Receives 12 serial bits via `di`
- Checks start bit, parity, and stop bits
- Extracts 8-bit data (`dout`)
- Outputs a strobe pulse when valid data is received

### Key Signals:
- `di`: Serial input
- `dout`: 8-bit received data
- `strobe`: High for 1 cycle when data is valid

---

## 🧪 Simulation Instructions

You can simulate using:
- **Vivado Simulator**
- **ModelSim**
- **Icarus Verilog (CLI-based)**

### Example using Icarus Verilog:
```bash
# Transmitter simulation
iverilog -o tx tb/tb_uart_trans.v src/uart_trans.v
vvp tx

# Receiver simulation
iverilog -o rx tb/tb_uart_recv.v src/uart_recv.v
vvp rx
