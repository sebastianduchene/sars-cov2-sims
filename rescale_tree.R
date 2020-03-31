
library(NELSI)
library(foreach)
library(doParallel)

set.seed(124)
tr <- rtree(20)
plot(tr)
tiplabels()
nodelabels()

get.tip.ages <- function(tr){
	     tips <- tr$edge[, 2][!tr$edge[, 2] %in% tr$edge[, 1]]
	     cl <- makeCluster(10)
	     registerDoParallel(cl)
	     path.length <- function(tip){
	     	ancestral_branches <- get.ancestor.nodes.branches(tr, tip)$ancestor.branches
      		return( sum(tr$edge.length[ancestral_branches]) )
	     }
	     tip_ages <- foreach(x = tips, .combine = c, .packages = c('NELSI', 'ape')) %dopar% path.length(x)

	     stopCluster(cl)
	     return(tip_ages)
}


chronogram_years <- read.tree('bd_100k_chronogram.tree')

tip_ages_years <- get.tip.ages(chronogram_years)
chronogram_years$tip.label <- paste0(chronogram_years$tip.label, '_', 2019+tip_ages_years)

evol_rate <- 1.2e-3

phylogram <- chronogram_years
phylogram$edge.length <- phylogram$edge.length * rlnorm(chronogram_years$edge.length, evol_rate, 0.1)

write.tree(phylogram, 'bd_100k_phylogram.tree')

