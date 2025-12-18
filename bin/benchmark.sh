#!/bin/bash
PROJECT_DIR="/home/youssef/MatrixMultiplicationAWS"
cd "$PROJECT_DIR" || exit

SIZE=${1:-1000}
CORES=(1 2 4 8)

echo "==============================================="
echo "   MPI MATRIX BENCHMARK: ${SIZE}x${SIZE}x${SIZE}"
echo "==============================================="
echo -e "Cores\t| Mode\t\t| Time (sec)"
echo "-----------------------------------------------"

for p in "${CORES[@]}"; do
    # Run the dispatcher and capture ONLY the time line
    RESULT=$(./bin/mm_run.sh $SIZE $SIZE $SIZE $p | grep "took")

    # Clean up the output to get just the number
    TIME=$(echo $RESULT | grep -oE '[0-9]+\.[0-9]+')

    if [ "$p" -eq 1 ]; then
        echo -e "$p\t| SEQUENTIAL\t| $TIME"
    else
        echo -e "$p\t| PARALLEL\t| $TIME"
    fi
done
echo "==============================================="
