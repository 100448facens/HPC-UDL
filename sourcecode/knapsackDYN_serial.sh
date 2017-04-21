#!/bin/bash

## Specifies the interpreting shell for the job.
#$ -S /bin/bash

## Specifies that all environment variables active within the qsub utility be exported to the context of the job.
#$ -V

## Execute the job from the current working directory.
#$ -cwd

## Parallel programming environment (mpich) to instantiate and number of computing slots.
#$ -pe mpich 1

## The  name  of  the  job.
#$ -N Serial

## The email to send the queue manager notifications. 
#$ -M 100448facens@gmail.com 

## The folders to save the standard and error outputs.
#$ -o $HOME/hpc-project/sourcecode/outputs
#$ -e $HOME/hpc-project/sourcecode/errors 

gcc -fopenmp knapsackDYN_serial.c -o knapsackDYN_serial

MPICH_MACHINES=$TMPDIR/mpich_machines
cat $PE_HOSTFILE | awk '{print $1":"$2}' > $MPICH_MACHINES


array=(
"../testbed/test_5_5" 
"../testbed/test_50_100"
"../testbed/test_50_1000"
"../testbed/test_50_10000"
"../testbed/test_500_100"
"../testbed/test_500_1000"
"../testbed/test_500_10000"
"../testbed/test_5000_100"
"../testbed/test_5000_1000"
"../testbed/test_5000_10000"
"../testbed/test_50000_100"
"../testbed/test_50000_1000"
"../testbed/test_50000_10000"
"../testbed/test_500000_100"
"../testbed/test_500000_1000"
"../testbed/test_500000_10000"
"../testbed/test_5000000_100"
"../testbed/test_5000000_1000"
"../testbed/test_5000000_10000"
)

for element in ${array[@]}
do
	## In this line you have to write the command that will execute your application.
	mpiexec -f $MPICH_MACHINES -n $NSLOTS ./knapsackDYN_serial $element
	##../testbed/test_5_5
done

rm -rf $MPICH_MACHINES