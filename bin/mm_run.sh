#!/bin/bash

# 1. SET ABSOLUTE PATHS
PROJECT_DIR="/home/youssef/MatrixMultiplicationAWS"
BIN_DIR="$PROJECT_DIR/bin"
TEST_DIR="$PROJECT_DIR/test"

# 2. INPUTS
m=$1; n=$2; l=$3; p=$4
W=$((m * n * l))
THRESHOLD=10000000

# 3. SETUP ENVIRONMENT
cd "$PROJECT_DIR" || exit
mkdir -p "$TEST_DIR"

# 4. RUN GENERATOR
"$BIN_DIR/writeMatrix" $m $n $n $l

# 5. DECISION LOGIC
if [ "$p" -le 1 ] || [ "$W" -lt "$THRESHOLD" ]; then
    echo "--- Decision: SEQUENTIAL (W: $W) ---"
    "$BIN_DIR/seq"
else
    echo "--- Decision: PARALLEL (W: $W | P: $p) ---"
    mpirun --oversubscribe -np "$p" "$BIN_DIR/par"
fi

# 3. CORRECTED PATH OUTPUT
echo "------------------------------------------------"
echo "Complete! The C code saved the results to your home folder."
echo "Input:  ~/test/infile"
echo "Output: ~/test/outfile"
echo "------------------------------------------------"
