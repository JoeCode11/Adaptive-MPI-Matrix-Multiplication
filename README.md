# 🚀 Adaptive MPI Matrix Multiplication Engine

A high-performance C-based matrix multiplication engine designed for distributed systems. This project features an **intelligent Bash-based dispatcher** that analyzes computational complexity before execution to determine the most efficient processing path.

---

## 🧠 Project Overview
Matrix multiplication efficiency depends heavily on the overhead of parallelization. This engine doesn't just run code; it makes a **heuristic decision** based on the workload size ($O(m \times n \times l)$) to choose between:
1.  **Sequential Execution:** For small matrices where MPI overhead would be slower.
2.  **MPI Parallel Execution:** For large-scale data where multi-core distribution is required.

---

## ✨ Key Features
* **Adaptive Execution:** Automatically switches to MPI-parallelized execution when the workload exceeds $10^7$ operations.
* **Dynamic Workload Analysis:** Minimizes communication overhead by calculating total operations before spinning up the MPI environment.
* **Automated Benchmarking:** Includes a "Scientist" script to measure scaling across 1, 2, 4, and 8+ cores.
* **WSL Optimized:** Specifically configured to handle process oversubscription in Windows Subsystem for Linux environments.

---

## 🏗️ Performance Architecture
The system is divided into three logical layers:

| Layer | Component | Responsibility |
| :--- | :--- | :--- |
| **Math Core** | `C / MPI` | Optimized row-decomposition for parallel distribution. |
| **The Brain** | `mm_run.sh` | Mathematical validity (inner-dimension matching) and execution logic. |
| **Analytics** | `benchmark.sh` | Performance reporting and hardware bottleneck ("Hardware Wall") identification. |

---

## 📊 Benchmark Results
Tested on a **1200 x 1200 x 1200** matrix (1.7 Billion Operations):

* **Sequential Time:** `9.38s`
* **Parallel Time (4 Cores):** `4.52s`
* **Achieved Speedup:** **2.07x** 🚀
* **Efficiency:** **~52%** (Optimized for local distributed memory constraints).

---

## 🛠️ Installation & Usage

### 1. Clone & Compile
Ensure you have an MPI library installed (like OpenMPI).
```bash
# Compile the matrix generator
gcc source/writeMatrix.c source/matrixOps.c -o bin/writeMatrix

# Compile Sequential version
gcc source/matrixMultiplicationS.c source/matrixOps.c -o bin/seq

# Compile Parallel version
mpicc source/matrixMultiplicationP.c source/matrixOps.c -o bin/par
```

### 2. Run the Dispatcher
Run the gateway script by providing dimensions: Rows_A, Cols_A/Rows_B, Cols_B, and Num_Processes.

```bash
# Usage: ./bin/mm_run.sh <m> <n> <l> <p>
./bin/mm_run.sh 500 500 500 4
```

### 3. Run Automated Benchmarks
Run the automated test suite to see how your hardware scales across different core counts.

```bash
# Automatically tests 1, 2, 4, and 8 cores for a specific size (default 1000)
./bin/benchmark.sh 1000
```
### 4. Project Structure

```text
MatrixMultiplicationAWS/
├── bin/                 # Compiled binaries and Bash logic scripts
│   ├── mm_run.sh        # The Execution Dispatcher
│   └── benchmark.sh     # The Performance Analytics Script
├── source/              # C source code files
│   ├── matrixOps.c      # Common matrix utilities
│   ├── matrixMultiplicationS.c  # Sequential Logic
│   └── matrixMultiplicationP.c  # MPI Parallel Logic
├── test/                # Local data storage (Ignored by Git)
│   ├── infile           # Generated input matrices
│   └── outfile          # Resultant matrix
└── README.md            # Documentation
```
