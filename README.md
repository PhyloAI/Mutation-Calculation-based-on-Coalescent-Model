# Mutation Calculation based on Coalescent Model (MuCCo)
MuCCo is an innovative method for assessing the influence of incomplete lineage sorting (ILS) on individual nodes within a phylogenetic tree by calculating the population mutation parameter, “theta”. Here, we wrote scripts to accommodate single-copy nuclear genes (SCN genes) assembled from Deep Genome Skimming (DGS) data. This adapted methodology is now formally introduced as “MuCCo”. The theta value for each internal branch is determined by dividing the branch length in mutation units, estimated from RAxML, by the branch length in coalescent units, obtained from the ASTRAL species tree.
## Dependencies
RAxML  
Figure Tree  
R: ape
## Input and output
### Input
Species tree, newick format;  
Alignments file, phylip or fasta format.
### Output
RAxML tree with branches labels reflecting mutation units;  
Species tree with node labels reflecting theta values.
## Pipeline Running
### Step 1: Inferring branch length in mutation unit based on fixed topology
Transforming model parameters and branch lengths for a given species tree.
```
raxmlHPC -f e -m GTRGAMMA -s <alignments> -t <species tree> -n <specifies the name of the output file>
```
### Step 2: Estimating theta value by dividing the branch lengths in mutation units by that in coalescent units
**Note**: To ensure the consistency of the topology of the two trees, we use Figure Tree to root and order the nodes.
```
# Install and load the ape package
install.packages("ape")
library(ape)

# Define the function to generate the scaled tree
generate_scaled_tree <- function(tree_file1, tree_file2, output_file) {
  # Read the two tree files
  tree1 <- read.tree(tree_file1)
  tree2 <- read.tree(tree_file2)
  
  # Extract the branch length vectors from both trees
  branch_lengths1 <- tree1$edge.length
  branch_lengths2 <- tree2$edge.length
  
  # Calculate the branch length ratio for each node
  branch_ratio <- branch_lengths1 / branch_lengths2
  
  # Create a new tree with branch lengths scaled by the ratio
  scaled_tree <- tree1
  scaled_tree$edge.length <- branch_ratio
  
  # Write the new tree to the specified output file
  write.tree(scaled_tree, file = output_file)
}

# Example usage
tree_file1 <- "raxml.tre"  # Path to the RAxML tree file
tree_file2 <- "astral.tre"  # Path to the ASTRAL tree file
output_file <- "Theta_tree.newick"  # Path to save the new tree file

generate_scaled_tree(tree_file1, tree_file2, output_file)
```
## Citation
Cai L, Xi Z, Lemmon EM, Lemmon AR, Mast A, Buddenhagen CE, Liu L, Davis CC. 2021. The perfect storm: Gene tree estimation error, incomplete lineage sorting, and ancient gene flow explain the most recalcitrant ancient angiosperm clade, Malpighiales. Systematic Biology 70: 491–507.
