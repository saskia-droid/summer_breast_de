
# overrepresentation analysis
# saskia perret-gentil 

# run previous script
#source("06_differential_expression_analysis.R")

# install and load libraries
BiocManager::install("clusterProfiler")
BiocManager::install("org.Hs.eg.db")
library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)

genes <- row.names(sig)
universe <- row.names(res)

egoMF <- clusterProfiler::enrichGO( gene          = genes,
                                    universe      = universe,
                                    OrgDb         = org.Hs.eg.db,
                                    ont           = "MF", # molecular function
                                    pAdjustMethod = "BH",
                                    pvalueCutoff  = 0.01,
                                    qvalueCutoff  = 0.05,
                                    readable      = TRUE,
                                    keyType       = 'ENSEMBL')
#head(egoMF)
dotplot(egoMF, showCategory=20)

# visualize enriched GO terms as a directed acyclic graph: 
#goplot(egoMF)

egoBP <- clusterProfiler::enrichGO( gene          = genes,
                                    universe      = universe,
                                    OrgDb         = org.Hs.eg.db,
                                    ont           = "BP", # biological process
                                    pAdjustMethod = "BH",
                                    pvalueCutoff  = 0.01,
                                    qvalueCutoff  = 0.05,
                                    readable      = TRUE,
                                    keyType       = 'ENSEMBL')
#head(egoBP)
dotplot(egoBP, showCategory=20)

egoALL <- clusterProfiler::enrichGO( gene          = genes,
                                    universe      = universe,
                                    OrgDb         = org.Hs.eg.db,
                                    ont           = "ALL", 
                                    pAdjustMethod = "BH",
                                    pvalueCutoff  = 0.01,
                                    qvalueCutoff  = 0.05,
                                    readable      = TRUE,
                                    keyType       = 'ENSEMBL')
#head(egoALL)
dotplot(egoALL, showCategory=20)
