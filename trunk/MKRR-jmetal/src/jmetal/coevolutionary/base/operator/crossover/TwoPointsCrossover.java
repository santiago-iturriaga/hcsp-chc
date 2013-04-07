package jmetal.coevolutionary.base.operator.crossover;


import jmetal.util.JMException;
import jmetal.util.PseudoRandom;
import jmetal.base.Configuration;
import jmetal.coevolutionary.base.Operator;
import jmetal.base.Configuration.* ; 
import jmetal.base.variable.Permutation;
import jmetal.coevolutionary.base.Solution;


/**
 * Class representing a two points crossover operator.
 * 
 * This class allows to apply a two points crossover operator using two parent
 * solutions.
 * <b>NOTE:</b> the operator is applied to the first variable of the solutions, and 
 * the type of the solutions must be <code>SolutionType_.Permutation</code>.
 * 
 * @author Antonio J. Nebro
 * @author Juan A. Ca�ero
 * @version 1.0
 */
public class TwoPointsCrossover extends Operator {

	private static final long serialVersionUID = 6094386276123091977L;


	/**
	 * Constructor
	 * Creates a new intance of the two point crossover operator
	 */
	public TwoPointsCrossover() {
	} // TwoPointsCrossover


	/**
	 * Perform the crossover operation
	 * @param probability Crossover probability
	 * @param parent1 The first parent
	 * @param parent2 The second parent
	 * @return Two offspring solutions
	 * @throws JMException 
	 */
	@SuppressWarnings("unchecked")
	public Solution[] doCrossover(double   probability, 
			Solution parent1, 
			Solution parent2) throws JMException {

		Solution [] offspring = new Solution[2];

		offspring[0] = new Solution(parent1);
		offspring[1] = new Solution(parent2);

		if (parent1.getDecisionVariables().variables_[0].getVariableType() ==
			VariableType_.Permutation) {
			if (PseudoRandom.randDouble() < probability) {
				int crosspoint1        ;
				int crosspoint2        ;
				int permutationLength  ;
				int parent1Vector[]    ;
				int parent2Vector[]    ;
				int offspring1Vector[] ;
				int offspring2Vector[] ;

				permutationLength = ((Permutation)parent1.getDecisionVariables().variables_[0]).getLength() ;
				parent1Vector     = ((Permutation)parent1.getDecisionVariables().variables_[0]).vector_ ;
				parent2Vector    = ((Permutation)parent2.getDecisionVariables().variables_[0]).vector_ ;    
				offspring1Vector = ((Permutation)offspring[0].getDecisionVariables().variables_[0]).vector_ ;
				offspring2Vector = ((Permutation)offspring[1].getDecisionVariables().variables_[0]).vector_ ;

				// STEP 1: Get two cutting points
				crosspoint1 = PseudoRandom.randInt(0,permutationLength-1) ;
				crosspoint2 = PseudoRandom.randInt(0,permutationLength-1) ;

				while (crosspoint2 == crosspoint1)  
					crosspoint2 = PseudoRandom.randInt(0,permutationLength-1) ;

				if (crosspoint1 > crosspoint2) {
					int swap ;
					swap        = crosspoint1 ;
					crosspoint1 = crosspoint2 ;
					crosspoint2 = swap          ;
				} // if

				// STEP 2: Obtain the first child
				int m = 0;
				for(int j = 0; j < permutationLength; j++) {
					boolean exist = false;
					int temp = parent2Vector[j];
					for(int k = crosspoint1; k <= crosspoint2; k++) {
						if (temp == offspring1Vector[k]) {
							exist = true;
							break;
						} // if
					} // for
					if (!exist) {
						if (m == crosspoint1)
							m = crosspoint2 + 1;
						offspring1Vector[m++] = temp;
					} // if
				} // for

				// STEP 3: Obtain the second child
				m = 0;
				for(int j = 0; j < permutationLength; j++) {
					boolean exist = false;
					int temp = parent1Vector[j];
					for(int k = crosspoint1; k <= crosspoint2; k++) {
						if (temp == offspring2Vector[k]) {
							exist = true;
							break;
						} // if
					} // for
					if(!exist) {
						if (m == crosspoint1)
							m = crosspoint2 + 1;
						offspring2Vector[m++] = temp;
					} // if
				} // for
			} // if 
		} // if
		else {
			Configuration.logger_.severe("TwoPointsCrossover.doCrossover: invalid " +
					"type" + 
					parent1.getDecisionVariables().variables_[0].getVariableType());
			Class cls = java.lang.String.class;
			String name = cls.getName(); 
			throw new JMException("Exception in " + name + ".doCrossover()") ; 
		} // else

		return offspring;                                                                                      
	} // makeCrossover



	/**
	 * Executes the operation
	 * @param object An object containing an array of two solutions 
	 * @return An object containing an array with the offSprings
	 * @throws JMException 
	 */
	@SuppressWarnings("unchecked")
	public Object execute(Object object,int none) throws JMException {
		Solution [] parents = (Solution [])object;
		Double crossoverProbability ;

		if ((parents[0].getType() != SolutionType_.Permutation) ||
				(parents[1].getType() != SolutionType_.Permutation)) {

			Configuration.logger_.severe("TwoPointsCrossover.execute: the solutions " +
					"are not of the right type. The type should be 'Permutation', but " +
					parents[0].getType() + " and " + 
					parents[1].getType() + " are obtained");
		} // if 

		crossoverProbability = (Double)getParameter("probability");

		if (parents.length < 2)	{
			Configuration.logger_.severe("SBXCrossover.execute: operator needs two " +
			"parents");
			Class cls = java.lang.String.class;
			String name = cls.getName(); 
			throw new JMException("Exception in " + name + ".execute()") ;      
		} // if
		else if (crossoverProbability == null){
			Configuration.logger_.severe("SBXCrossover.execute: probability not " +
			"specified");
			Class cls = java.lang.String.class;
			String name = cls.getName(); 
			throw new JMException("Exception in " + name + ".execute()") ;  
		} // else if

		Solution [] offspring = doCrossover(crossoverProbability.doubleValue(),
				parents[0],
				parents[1]);

		return offspring; 
	} // execute


} // TwoPointsCrossover