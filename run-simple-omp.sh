#!/bin/bash

## Specifies the interpreting shell for the job.
#$ -S /bin/bash

## Specifies that all environment variables active within the qsub utility be exported to the context of the job.
#$ -V

## Specifies the parallel environment
#$ -pe smp 4

## Execute the job from the current working directory.
#$ -cwd

## The  name  of  the  job.
##$ -N test

##Passes an environment variable to the job
##$ -v  OMP_NUM_THREADS=4

## Els directoris de la sortida normal i d'error (opcional)
#$ -o output
#$ -e errors
#$ -j y

## In this line you have to write the command that will execute your application.
./$1 $2
