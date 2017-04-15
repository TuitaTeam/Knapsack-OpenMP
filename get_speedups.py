#!/usr/bin/python

import sys

if len(sys.argv) != 2:
    print "Usage:", sys.argv[0], "<results_file.csv>"
    exit(1)

f = open(sys.argv[1], 'r')

results = {}

for line in f:
   l = line.split()
   if len(l) == 6:
       results[(l[0], l[1], l[5])] = l[4]

f.close()
f = open(sys.argv[1], 'r')

print "Width Items Result ProblemSolvingTime TotalTime Nthreads SpeeUp"
for line in f:
   line = line.strip('\n')
   l = line.split()
   try:
       if len(l) == 6:
           if l[5] == '1':
               sys.stdout.write(line + ' 1\n')
           else:
               speedup = float(results[(l[0], l[1], '1')]) / float(l[4])
               sys.stdout.write(line + ' ' + str(speedup) + '\n')
   except:
       pass

f.close()
