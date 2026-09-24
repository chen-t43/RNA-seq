library(ggplot2)
library(FactoMineR)
library(openxlsx)
library(ggrepel)
library(DESeq2)
library(dplyr)
library(tidyr)
countdata<-read.table("./counts.txt",header = T)
countdata<-countdata[,c(1,7:12)]
rownames(countdata)<-countdata[,1]
countdata<-countdata[,-1]
coldata<-read.xlsx('./sample.xlsx')
countdata <- countdata[rowMeans(countdata)>1,] 
countdata <- countdata[complete.cases(countdata),]
dds <- DESeqDataSetFromMatrix(countdata, colData = coldata, design = ~condition)
dds <- DESeq(dds)
sizeFactors(dds)
res = results(dds,contrast=c("condition", "M", "F"))
res = res[order(res$pvalue),]
summary(res)
res<-as.data.frame(res)
res<-cbind(rownames(res),res)
colnames(res)[1]<- c('gene_id')
table(res$padj<0.05)
DEG <- as.data.frame(res)
DESeq2_DEG <- na.omit(DEG)
diff_padj0.05 <- subset(DESeq2_DEG,padj < 0.01)
diff_padj0.05_FC1 <- subset(diff_padj0.05,log2FoldChange < -12 | log2FoldChange > 12)
diff_padj0.05_FC1[which(diff_padj0.05_FC1$log2FoldChange>0),'up_down']<-'up'
diff_padj0.05_FC1[which(diff_padj0.05_FC1$log2FoldChange<0),'up_down']<-'down'
