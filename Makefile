SERIAL_TARGET_DYN=knapsackDYN_serial
SERIAL_TARGET_BB=knapsackBB_serial
OMP_TARGET_DYN=knapsackDYN_omp
OMP_TARGET_BB=knapsackBB_omp
RESULTS=results.csv
RESULTS_SPEEDUPS=results_speedups.csv
RESULTS_TIMES=results_times_per_problem.csv
OUTPUT_FOLER=output
ERROR_FOLDER=errors

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

run-local : dyn
	./run_all_local.sh

run-moore : dyn
	./run_all.sh

results : $(RESULTS) $(RESULTS_TIMES) $(RESULTS_SPEEDUPS)

$(RESULTS) : $(OUTPUT_FOLER)/*
	./get_results.sh > $(RESULTS)

$(RESULTS_TIMES) : $(RESULTS)
	./get_times_per_problem.py $(RESULTS) > $(RESULTS_TIMES)

$(RESULTS_SPEEDUPS) : $(RESULTS)
	./get_speedups.py $(RESULTS) > $(RESULTS_SPEEDUPS)

plot : $(RESULTS_TIMES)
	./plot_generator.py $(RESULTS_TIMES)

clean :
	rm -rf $(SERIAL_TARGET_DYN) $(OMP_TARGET_DYN) $(SERIAL_TARGET_BB) $(OMP_TARGET_BB) $(RESULTS) $(RESULTS_SPEEDUPS) $(RESULTS_TIMES)

clean-outputs :
	rm -rf $(OUTPUT_FOLER)

clean-errors :
	rm -rf $(ERROR_FOLDER)