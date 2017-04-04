SERIAL_TARGET=knapsackDYN_serial
OMP_TARGET=knapsackDYN_omp

all : serial omp

serial : knapsackDYN_serial_optimized.c
	gcc knapsackDYN_serial_optimized.c -o $(SERIAL_TARGET)

omp : knapsackDYN_omp.c
	gcc -fopenmp knapsackDYN_omp.c -o $(OMP_TARGET)

clean :
	rm $(SERIAL_TARGET) $(OMP_TARGET)