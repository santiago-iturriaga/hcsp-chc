#Sintaxis: ./generator <num_tasks> <num_machines> <task_heterogeneity> <machine_heterogeneity> <consistency> [model] [type] [seed]
#Task heterogeneity levels: (0-Low, 1-High), machine heterogeneity levels: (0-Low, 1-High).
#Consistency type: (0-Consistent, 1-Semiconsistent, 2-Inconsistent).
#Optional: heterogeneity model: (0-Ali et al., 1-Braun et al.).
#	Ranks (tasks, machines) 0(Ali):(10-100000,10-100), 1(Braun):(100-3000,10-1000).
#	(ranks by Braun et al. (100-3000,10-1000) assumed by default).
#Optional: type of task execution times: (0-real, 1-integer).
#Optional: seed for the pseudorandom number generator.

#A.u_c_hihi
../generar 4096 128 1 1 0 0 0 1240440634