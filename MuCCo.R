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
tree_file1 <- "gene_f.tre"  # Path to the RAxML tree file
tree_file2 <- "astral_f.tre"  # Path to the ASTRAL tree file
output_file <- "Theta_tree.newick"  # Path to save the new tree file

generate_scaled_tree(tree_file1, tree_file2, output_file)
