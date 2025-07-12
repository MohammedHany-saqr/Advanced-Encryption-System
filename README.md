# 🔐 Advanced Encryption System (AES) - Verilog Implementation

This repository contains a full RTL-level Verilog implementation of the **Advanced Encryption Standard (AES)** algorithm, following the official [FIPS PUB 197](https://csrc.nist.gov/publications/detail/fips/197/final) specification.

The design supports **AES-128** encryption and decryption, with modular and synthesizable Verilog code suitable for simulation, testing, and FPGA/ASIC deployment.

---

## 📦 Project Overview

- ✅ **AES-128** bit symmetric block cipher  
- 🧩 Modular Verilog files for each AES transformation  
- 🧪 Includes a testbench (`subBytes_tb.v`)  
- 📄 Includes official specification: `NIST.FIPS.197.pdf`

---

## 🧠 Core Features

- **KeyExpansion** for round keys  
- **SubBytes** and **InverseSubBytes**  
- **ShiftRows** and **InverseShiftRows**  
- **MixColumns** and **InverseMixColumns**  
- **AddRoundKey**  
- **Full encryption (`Encryption.v`) and decryption (`Decrypt.v`) modules**  
- **Top-level integration** in `EDAES.v`  
- **All transformations written 100% in Verilog HDL**

---

## 📁 File Structure

- ├── addRoundKey.v # XORs state with round key
- ├── Decrypt.v # AES decryption top module
- ├── EDAES.v # AES top-level wrapper
- ├── Encryption.v # AES encryption top module
- ├── inverseMixColumns.v # Inverse MixColumns transformation
- ├── inverseSbox.v # Inverse S-box lookup table
- ├── inverseShiftRows.v # Inverse ShiftRows transformation
- ├── inverseSubBytes.v # Inverse SubBytes transformation
- ├── KeyExpansion.v # AES key schedule expansion
- ├── MixColumns.v # MixColumns transformation
- ├── NIST.FIPS.197.pdf # Official AES specification (FIPS 197)
- ├── sbox.v # S-box lookup table
- ├── shiftRows.v # ShiftRows transformation
- ├── subBytes.v # SubBytes transformation
- ├── subBytes_tb.v # Testbench for SubBytes
- ├── README.md # This file

---

## 🚀 How to Simulate

1. **Clone the repository**
git clone https://github.com/MohammedHany-saqr/Advanced-Encryption-System.git
cd Advanced-Encryption-System
Run simulation (example using Icarus Verilog)

iverilog -o test_sub subBytes_tb.v subBytes.v sbox.v
vvp test_sub
View output in terminal or waveform (with GTKWave if .vcd used)

📖 Reference

📄 NIST.FIPS.197.pdf — Official AES specification by NIST

🔗 FIPS PUB 197 (NIST)


📘 Suggested Tools

🧪 Simulation: Icarus Verilog, ModelSim

🖥️ Synthesis: Vivado, Quartus

📊 Waveform viewer: GTKWave
