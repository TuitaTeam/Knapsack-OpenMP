#!/usr/bin/python

import sys, random

problems_folder="problems"

nitems = int(sys.argv[1])
weight = int(sys.argv[2])

f = open(problems_folder + '/' + str(nitems) + '_' + str(weight), 'w')

f.write(str(nitems) + ' ' + str(weight) + '\n')

for i in xrange(nitems):
    f.write( " " + str(random.randint(1, 100)) + ", " + str(random.randint(1, weight)) + '\n')
