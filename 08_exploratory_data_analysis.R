
# exploratory data analysis
# saskia perret-gentil 

# clear environment
rm(list = ls())

# install, load libraries
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DESeq2")
BiocManager::install("biomaRt")

library(DESeq2)
library(pheatmap)
library(RColorBrewer)
library(biomaRt)

# import featureCounts.txt
fc_data <- read.table("/Users/saskia/unibe19/RNA-sequencing/2021_summer_project/04_featurecounts/featurecounts.txt",
                      sep='\t', header = TRUE)
#str(fc_data)

# transform the dataframe into a matrix
count_matrix <- as.matrix(fc_data);

rm(fc_data)

# remove columns that we don't need
count_matrix <- count_matrix[, -c(2, 3, 4, 5, 6)];

# transforming first column in row labels
rownames(count_matrix) <- count_matrix[,1]
count_matrix <- count_matrix[, -1]

class(count_matrix) <- "numeric"

# changing colnames of the count_matrix
for ( col in 1:ncol(count_matrix)){
  colnames(count_matrix)[col] <-  sub("X.data.courses.rnaseq.summer_practical.sperretgentil.03_map_reads.", "", colnames(count_matrix)[col], fixed = TRUE)
  colnames(count_matrix)[col] <-  sub(".sorted.bam", "", colnames(count_matrix)[col], fixed = TRUE)
}
rm(col)

# create coldata matrix
samples <- colnames(count_matrix); samples
tissue <- c("normal", "normal", "normal", "TNBC", "TNBC", "TNBC"); tissue
coldata <- cbind(samples, tissue); coldata
rownames(coldata) <- coldata[,1]; coldata
coldata <- coldata[, -1, drop = FALSE]; coldata
rm(samples)
rm(tissue)

# create DESeq object
dds <- DESeqDataSetFromMatrix(countData = count_matrix,
                              colData = coldata,
                              design = ~ tissue)

# run DESeq
dds <- DESeq(dds)

# to remove the dependence of the variance on the mean
# variance stabilizing transformations (VST)
vsd <- vst(dds, blind=TRUE)
#head(assay(vsd))

# PCA
#print(plotPCA(vsd, intgroup=c("tissue")))

### heatmap

# colors of the heat map
hmcolor <- colorRampPalette(brewer.pal(9, "GnBu"))(100)
ann_color = list(tissue = c(normal = "deeppink2", TNBC = "deeppink4"))

# selecting do the 20 more expressed genes
select <- order(rowMeans(counts(dds,normalized=TRUE)),
                decreasing=TRUE)[1:20]

df <- as.data.frame(colData(dds)[,c("tissue"), drop =FALSE])
rownames(df) <- colnames(count_matrix)

heat_map_matrix <- assay(vsd)[select,]

# change gene id to gene symbol 
mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl"))
genes <- rownames(heat_map_matrix)
G_list <- getBM(filters = "ensembl_gene_id", 
                attributes = c("ensembl_gene_id", "hgnc_symbol", 
                               "wikigene_description"), 
                values = genes, mart = mart)

rownames(G_list) <- G_list$ensembl_gene_id
onlyG_list <- G_list[,2, drop = FALSE]

rownames(heat_map_matrix) <- onlyG_list[rownames(heat_map_matrix),]

pheatmap(heat_map_matrix, color = hmcolor, border_color = NA, 
         cluster_rows = FALSE, cluster_cols = TRUE,
         annotation_col=df, annotation_colors = ann_color,
         show_rownames = TRUE)
