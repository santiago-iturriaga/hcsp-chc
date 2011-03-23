data[6]="u_c_hihi"

for i in {6..6}
do
	CfgFile="/home/siturria/AE/trunk/AE/CHC/hcsp/ejecuciones/scripts_evaluacion/chc_lan.cfg"
	DataFile="/home/siturria/AE/trunk/AE/ProblemInstances/HCSP/Braun_et_al.CPrio/${data[i]}"
	OutputFile="/home/siturria/AE/trunk/AE/CHC/hcsp/tests/resultados/prueba_lan_${data[i]}"
	
	echo "${CfgFile}" > /home/siturria/AE/trunk/AE/CHC/hcsp/tests/resultados/prueba_lan.cfg
	echo "$DataFile" >> /home/siturria/AE/trunk/AE/CHC/hcsp/tests/resultados/prueba_lan.cfg
	echo "$OutputFile.sol" >> /home/siturria/AE/trunk/AE/CHC/hcsp/tests/resultados/prueba_lan.cfg
	
	time(/home/siturria/bin/mpich2-1.2.1p1/bin/mpirun -n 8 /home/siturria/AE/trunk/AE/CHC/hcsp/MainLan \
		/home/siturria/AE/trunk/AE/CHC/hcsp/tests/resultados/prueba_lan.cfg > $OutputFile.log) 
done
