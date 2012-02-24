working_path="/home/santiago/workspace/AE-MF-Barca-2011/CHC/hcsp"
scripts_path="/home/santiago/Scheduling/Instances/Makespan/512x16"
instance_i="B.u_i_hihi"
instance_c="B.u_c_hihi"

DataFileI="${scripts_path}/${instance_i}"
OutputFileI="${working_path}/tests/resultados/i_${data[i]}"

DataFileC="${scripts_path}/${instance_c}"
OutputFileC="${working_path}/tests/resultados/c_${data[i]}"

CfgFile="${working_path}/ejecuciones/config-0512.cfg"
PesosFile="${working_path}/ejecuciones/pesos_3.txt"

echo "${CfgFile}" > ${working_path}/tests/resultados/prueba_lan.cfg
echo "${DataFileI}" >> ${working_path}/tests/resultados/prueba_lan.cfg
echo "${OutputFileI}.sol" >> ${working_path}/tests/resultados/prueba_lan.cfg
echo "${PesosFile}" >> ${working_path}/tests/resultados/prueba_lan.cfg
echo "512" >> ${working_path}/tests/resultados/prueba_lan.cfg
echo "16" >> ${working_path}/tests/resultados/prueba_lan.cfg

time(mpirun -n 3 ${working_path}/MainLan ${working_path}/tests/resultados/prueba_lan.cfg > ${OutputFileI}.log) 

echo "${CfgFile}" > ${working_path}/tests/resultados/prueba_lan.cfg
echo "${DataFileC}" >> ${working_path}/tests/resultados/prueba_lan.cfg
echo "${OutputFileC}.sol" >> ${working_path}/tests/resultados/prueba_lan.cfg
echo "${PesosFile}" >> ${working_path}/tests/resultados/prueba_lan.cfg
echo "512" >> ${working_path}/tests/resultados/prueba_lan.cfg
echo "16" >> ${working_path}/tests/resultados/prueba_lan.cfg

#time(mpirun -n 3 ${working_path}/MainLan ${working_path}/tests/resultados/prueba_lan.cfg > ${OutputFileC}.log) 
	