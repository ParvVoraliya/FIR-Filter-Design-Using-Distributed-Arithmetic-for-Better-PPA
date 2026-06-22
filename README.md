# FIR Filter Design Using Distributed Arithmetic (DA)

A hardware-efficient implementation of a **16-tap Low Pass FIR Filter** using **Distributed Arithmetic (DA)** in **Verilog HDL**. The design eliminates multipliers by replacing them with Look-Up Tables (LUTs), shift operations, and accumulation, making it suitable for FPGA and ASIC implementations with reduced hardware complexity.

---

## 📌 Features

- 16-Tap Low Pass FIR Filter
- Multiplier-less Distributed Arithmetic architecture
- LUT-based coefficient storage
- Shift-and-Accumulate computation
- Verilog HDL implementation
- FPGA synthesizable design
- Reduced hardware area and power consumption

---

## 🏗️ Architecture

The proposed architecture consists of:

- 16-stage input shift register
- Four 16×13-bit ROM LUTs
- Shift and Accumulate unit
- Adder
- Output register

The input samples are serially processed bit-by-bit. Instead of performing multiplication, LUTs generate precomputed partial sums which are shifted and accumulated to produce the final filter output.

---

## 📊 Filter Specifications

| Parameter | Value |
|-----------|-------|
| Filter Type | Low Pass FIR |
| Filter Order | 16 |
| Input Width | 10 bits |
| Output Width | 22 bits |
| LUT Size | 16 × 13 bits |
| Architecture | Distributed Arithmetic |
| HDL | Verilog |

---

## 📑 Filter Coefficients

| Tap | Coefficient |
|-----|-------------|
| h(0) | 0.0328 |
| h(1) | 0.0816 |
| h(2) | -0.0065 |
| h(3) | -0.0047 |
| h(4) | 0.0847 |
| h(5) | -0.0694 |
| h(6) | -0.0550 |
| h(7) | 0.5763 |
| h(8) | 0.5763 |
| h(9) | -0.0550 |
| h(10) | -0.0694 |
| h(11) | 0.0847 |
| h(12) | -0.0047 |
| h(13) | -0.0065 |
| h(14) | 0.0816 |
| h(15) | 0.0328 |

---

## ⚙️ Working

1. New input samples are loaded into a 16-stage shift register.
2. One bit from each stored sample is processed during every clock cycle.
3. These bits form the address for the LUTs.
4. The LUTs output precomputed partial sums.
5. Partial sums are shifted according to the bit position.
6. The accumulator adds the shifted values.
7. After processing all 10 bits of the input samples, the final filtered output is generated.

---

## 📂 Project Structure

```
FIR-Filter-Using-Distributed-Arithmetic/
│
├── fir_da.v                # Top module
├── README.md
├── architecture.png
├── waveform.png
├── synthesis_report.png
├── magnitude_response.png
└── coefficients.png
```

---

## 🛠️ Synthesis Summary

| Resource | Count |
|----------|------:|
| ROMs | 4 |
| 16×13-bit ROM | 4 |
| Adders | 4 |
| Registers | 20 |
| Multiplexers | 16 |
| Counter | 1 |
| Logic Shifters | 2 |

---

## 📈 Simulation Result

The waveform verifies the correct operation of the FIR filter. After all input bits are processed, the filtered output is produced through the shift-and-accumulate operation.

---

## 📉 Frequency Response

The implemented filter exhibits a Low Pass frequency response with good passband characteristics and high stopband attenuation.

---

## 💻 Tools Used

- Verilog HDL
- Xilinx ISE
- ISim / ModelSim
- MATLAB (Coefficient generation & Frequency response)
- Spartan-2E FPGA

---

## Advantages

- Eliminates hardware multipliers
- Reduced logic utilization
- Lower power consumption
- Area-efficient implementation
- FPGA friendly architecture
- Suitable for fixed coefficient FIR filters

---

## Future Scope

- Parameterized filter order
- Pipelined Distributed Arithmetic architecture
- Runtime programmable coefficients
- ASIC implementation
- High-speed optimized architecture

---

## Conclusion

This project demonstrates a multiplier-less implementation of a 16-tap Low Pass FIR filter using Distributed Arithmetic. By replacing conventional multipliers with LUTs and shift-and-accumulate operations, the design significantly reduces hardware complexity while maintaining filtering accuracy. The architecture is suitable for FPGA implementation and serves as an efficient solution for low-power and area-constrained digital signal processing applications.
