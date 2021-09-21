
# differential expression analysis
# saskia perret-gentil

# run previous script
#source("05_exploratory_data_analysis.R")

# lists the coefficients
#resultsNames(dds)

# get differentially expressed genes
res <- results(dds, contrast=c("tissue", "TNBC", "normal"))

# number of genes differentially expressed
sig <- res[!is.na(res$padj) & res$padj < 0.05 & abs(res$log2FoldChange) > 1,]; #nrow(sig) # 13170
up <- subset(sig, log2FoldChange > 0); #nrow(up) # 8716
down <- subset(sig, log2FoldChange < 0); #nrow(down) # 4454

getBM(filters = "ensembl_gene_id", 
      attributes = c("ensembl_gene_id", "hgnc_symbol", 
                     "wikigene_description"), 
      values = c("ENSG00000091831", "ENSG00000082175", "ENSG00000141736"), mart = mart)

# estrogen receptor 1: ENSG00000091831
plotCounts(dds, gene = "ENSG00000091831", intgroup = c("tissue"), main = "estrogen receptor 1", xlab = "")

# progesterone receptor: ENSG00000082175
plotCounts(dds, gene = "ENSG00000082175", intgroup = c("tissue"), main = "progesterone receptor", xlab = "")

# erb-b2 receptor tyrosine kinase 2: ENSG00000141736
plotCounts(dds, gene = "ENSG00000141736", intgroup = c("tissue"), main = "ERBB2", xlab = "")


# RACK1 ENSG00000204628 receptor for activated C kinase 1 GNB2L1
plotCounts(dds, gene = "ENSG00000204628", intgroup = c("tissue"), main = "RACK1", xlab = "")

# FTL ENSG00000087086 ferritin light chain
plotCounts(dds, gene = "ENSG00000087086", intgroup = c("tissue"), main = "FTL", xlab = "")

# OAZ1 ENSG00000104904 ornithine decarboxylase antizyme 1
plotCounts(dds, gene = "ENSG00000104904", intgroup = c("tissue"), main = "OAZ1", xlab = "")


# SPARC osteonectin ENSG00000113140: 
#plotCounts(dds, gene = "ENSG00000113140", intgroup = c("tissue"))
# calnexin (CANX) ENSG00000127022: 
#plotCounts(dds, gene = "ENSG00000127022", intgroup = c("tissue"))
# calreticulin (CALR) ENSG00000179218: 
#plotCounts(dds, gene = "ENSG00000179218", intgroup = c("tissue"))
# B2M ENSG00000166710: 
#plotCounts(dds, gene = "ENSG00000166710", intgroup = c("tissue"))
# APOE ENSG00000130203: 
#plotCounts(dds, gene = "ENSG00000130203", intgroup = c("tissue"))
# FN1 ENSG00000115414: 
#plotCounts(dds, gene = "ENSG00000115414", intgroup = c("tissue"))
# PPP1CB ENSG00000213639: 
#plotCounts(dds, gene = "ENSG00000213639", intgroup = c("tissue"))

