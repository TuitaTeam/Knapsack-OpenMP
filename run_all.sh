#!/bin/bash

THREADS="2 3 4"
#PROBLEMS=$(find problems -name "*" -type f)
PROBLEMS=$(find testbed -name "*" -type f)
SERIAL="./knapsackDYN_serial"
PARALLEL="./knapsackDYN_omp"

if [ ! -d "output" ]; then
    mkdir output
fi
if [ ! -d "errors" ]; then
    mkdir errors
fi

for PROBLEM in $PROBLEMS; do
    THREAD=1
    PROBLEM_NAME=$(head -n 1 $PROBLEM | awk '{print $1 "_" $2}')
    qsub -N "P.$PROBLEM_NAME.$THREAD" -pe smp $THREAD -v OMP_NUM_THREADS=$THREAD run-simple-omp.sh $SERIAL $PROBLEM
    for THREAD in $THREADS; do
        qsub -N "P.$PROBLEM_NAME.$THREAD" -pe smp $THREAD -v OMP_NUM_THREADS=$THREAD run-simple-omp.sh $PARALLEL $PROBLEM
    done
done
