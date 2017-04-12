SERIAL_TARGET_DYN=knapsackDYN_serial
SERIAL_TARGET_BB=knapsackBB_serial
OMP_TARGET_DYN=knapsackDYN_omp
OMP_TARGET_BB=knapsackBB_omp

all : serial omp

dyn : $(SERIAL_TARGET_DYN) $(OMP_TARGET_DYN)

bb : $(SERIAL_TARGET_BB) $(OMP_TARGET_BB)

serial : $(SERIAL_TARGET_DYN) $(SERIAL_TARGET_BB)

$(SERIAL_TARGET_DYN) : knapsackDYN_serial_optimized.c
	gcc knapsackDYN_serial_optimized.c -o $(SERIAL_TARGET_DYN)

$(SERIAL_TARGET_BB) : knapsackBB_serial.cpp
	g++ knapsackBB_serial.cpp -o $(SERIAL_TARGET_BB)

omp : $(OMP_TARGET_DYN) $(OMP_TARGET_BB)

$(OMP_TARGET_DYN) : knapsackDYN_omp.c
	gcc -fopenmp knapsackDYN_omp.c -o $(OMP_TARGET_DYN)

$(OMP_TARGET_BB) : knapsackBB_omp.cpp
	g++ -fopenmp knapsackBB_omp.cpp -o $(OMP_TARGET_BB)

clean :
	rm -rf $(SERIAL_TARGET_DYN) $(OMP_TARGET_DYN) $(SERIAL_TARGET_BB) $(OMP_TARGET_BB)