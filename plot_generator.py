#!/usr/bin/python

import pylab as pl
import sys

number_of_cores = [1, 2, 3, 4]
times = {}

def readData(filename):
    f = open(filename, 'r')
    for line in f:
        try:
            l = line.split()
            t = []
            t.append(float(l[2]))
            t.append(float(l[3]))
            t.append(float(l[4]))
            t.append(float(l[5]))
            times[(l[0], l[1])] = t
        except:
            pass
    f.close()

def plot(filename):
    pl.figure(figsize=(15,10), dpi=80, facecolor='white', edgecolor='k')
    for key, value in times.items():
        pl.plot(number_of_cores, value, linewidth=2, label='Width: ' + key[0] + ' Items: ' + key[1])
    pl.legend()
    pl.xlabel('Number of cores')
    pl.ylabel('Time (s)')
    pl.xticks([1, 2, 3, 4])
    pl.grid()
    pl.savefig(filename)
    pl.show()

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print "Usage:", sys.argv[0], "<data_file.csv>"
        exit(1)
    readData(sys.argv[1])
    plot(sys.argv[1] + '.svg')