#!/usr/bin/python

import sys, random
import os

problems_folder="problems"

if len(sys.argv) != 3:
    print "Usage:", sys.argv[0], "<nitems> <weight>"
    exit(1)

nitems = int(sys.argv[1])
weight = int(sys.argv[2])

if (not os.path.exists(problems_folder)):
    print "ERROR: directory", problems_folder, "does not exists!"
    exit(1)

f = open(problems_folder + '/' + str(nitems) + '_' + str(weight), 'w')

f.write(str(nitems) + ' ' + str(weight) + '\n')

for i in xrange(nitems):
    f.write( " " + str(random.randint(1, 100)) + ", " + str(random.randint(1, weight)) + '\n')
