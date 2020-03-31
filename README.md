# Notes to generate alignment with 100K samples with SARS-nCoV-2 parameters

- The MASTER file (BD_100k_sim.xml) can be run in BEAST2 to simulate a phylogenetic tree with $R[0]$=2.5 under a constant birth-death process with sampling. The xml code includes annotations to change any parameters.

- The R script (rescale_tree.R) takes the tree from MASTER and multiplies the branch lengths by a substitution rate. Note that the sampling times are the distance from the root to each tip and are shown after _ in the tip names.

- The tree from above can then be used to generate a sequence alignment. We used seqgen as follows:

```seqgen bd_100k_phylogram.tree -m GTR -l 29903 -r 0.2858 1.1731 0.2123 0.3217 3.0578 1.0000 -f 0.2987 0.1837 0.1964 0.3213 -i 0.6041 -a 4.4 -g 3 -of > bd_100k_seq.fasta```

- The substitution model parameters were estimated using IQTREE with the output below. Note that in seqgen we cannot use the free rates model, so we use a gamma distribution that has a similar shape to the three rates below.


SUBSTITUTION PROCESS
--------------------

Model of substitution: GTR+F+I+R3

Rate parameter R:

A-C: 0.2858

A-G: 1.1731

A-T: 0.2123

C-G: 0.3217

C-T: 3.0578


G-T: 1.0000

State frequencies: (empirical counts from alignment)

pi(A) = 0.2987

pi(C) = 0.1837

pi(G) = 0.1964

pi(T) = 0.3213

Rate matrix Q:

A   -0.4876   0.07291      0.32   0.09473

C    0.1186    -1.571   0.08776     1.364

G    0.4867   0.08207    -1.015    0.4462

T   0.08809    0.7801    0.2728    -1.141

Model of rate heterogeneity: Invar+FreeRate with 3 categories

Proportion of invariable sites: 0.6041

Site proportion and rates:  (0.202,2.077) (0.1916,2.271) (0.002302,63.1)

Category  Relative_rate  Proportion

0         0              0.6041

1         2.077          0.202

2         2.271          0.1916

3         63.1           0.002302





