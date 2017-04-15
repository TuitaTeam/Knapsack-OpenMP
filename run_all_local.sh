#!/bin/bash

THREADS="2 3 4"
#PROBLEMS=$(find problems -name "*" -type f)
PROBLEMS=$(find testbed -name "*" -type f)
SERIAL="./knapsackDYN_serial"
PARALLEL="./knapsackDYN_omp"

if [ ! -d "output" ]; then
    mkdir output
fi

for PROBLEM in $PROBLEMS; do
    THREAD=1
    PROBLEM_NAME=$(head -n 1 $PROBLEM | awk '{print $1 "_" $2}')
    echo -e "Running $PROBLEM_NAME.$THREAD..."
    $SERIAL $PROBLEM | tee "output/P.$PROBLEM_NAME.$THREAD.o"
    for THREAD in $THREADS; do
        echo -e "Running $PROBLEM_NAME.$THREAD..."
        $PARALLEL $PROBLEM $THREAD | tee "output/P.$PROBLEM_NAME.$THREAD.o"
    done
done
