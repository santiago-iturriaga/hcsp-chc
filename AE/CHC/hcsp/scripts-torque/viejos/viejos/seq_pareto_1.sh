#!/bin/bash

# Nombre del trabajo
#PBS -N ae_seq_fp1

# Requerimientos
#PBS -l nodes=1:cpu8,walltime=01:00:00

# Cola
#PBS -q publica

# Working dir
#PBS -d /home/siturria/AE/trunk/AE/CHC/hcsp/ejecuciones/

# Correo electronico
###PBS -M siturria@fing.edu.uy

# Email
#PBS -m abe
# n: no mail will be sent.
# a: mail is sent when the job is aborted by the batch system.
# b: mail is sent when the job begins execution.
# e: mail is sent when the job terminates.

# Output path
#PBS -e /home/siturria/AE/trunk/AE/CHC/hcsp/ejecuciones/frente_pareto/seq/
#PBS -o /home/siturria/AE/trunk/AE/CHC/hcsp/ejecuciones/frente_pareto/seq/

#PBS -V

echo Job Name: $PBS_JOBNAME
echo Working directory: $PBS_O_WORKDIR
echo Queue: $PBS_QUEUE
echo Cantidad de tasks: $PBS_TASKNUM
echo Home: $PBS_O_HOME
echo Puerto del MOM: $PBS_MOMPORT
echo Nombre del usuario: $PBS_O_LOGNAME
echo Idioma: $PBS_O_LANG
echo Cookie: $PBS_JOBCOOKIE
echo Offset de numero de nodos: $PBS_NODENUM
echo Shell: $PBS_O_SHELL
#echo JobID: $PBS_O_JOBID
echo Host: $PBS_O_HOST
echo Cola de ejecucion: $PBS_QUEUE
echo Archivo de nodos: $PBS_NODEFILE
echo Path: $PBS_O_PATH

echo
cd $PBS_O_WORKDIR
echo Current path: 
pwd
echo
echo Nodos:
cat $PBS_NODEFILE
echo
# Define number of processors
echo Cantidad de nodos:
NPROCS=`wc -l < $PBS_NODEFILE`
echo $NPROCS
echo

Data="u_s_hilo.0"

for index in {1..1}
do
	CfgFile="/home/siturria/AE/trunk/AE/CHC/hcsp/ejecuciones/scripts_frente_pareto/chc_$index.cfg"
	DataFile="/home/siturria/AE/trunk/AE/ProblemInstances/HCSP/Braun_et_al.CPrio/$Data"
	
	echo "==========================================================="
	echo "Datos $DataFile"
	echo "==========================================================="
	
	for i in {0..4}
	do
		OutputFile="/home/siturria/AE/trunk/AE/CHC/hcsp/ejecuciones/frente_pareto/seq/${index}_${i}"
		
		/home/siturria/AE/trunk/AE/CHC/hcsp/MainSeq $CfgFile $DataFile \
			$OutputFile.sol > $OutputFile.log
	done    
done
