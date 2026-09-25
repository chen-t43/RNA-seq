library(pheatmap)
library(ggplot2)
library(dplyr)
library(openxlsx)
library(readxl)
breaks_list <- seq(-2, 2, by = 0.01)
my_custom_color <- colorRampPalette(c("#6BAED6", "#FFFFFF", "#F03B20"))(length(breaks_list) - 1)
pheatmap(data, 
         scale = 'row', 
         clustering_distance_rows = "euclidean", 
         clustering_distance_cols = "euclidean", 
         clustering_method = "complete", 
         show_rownames = TRUE, 
         show_colnames = TRUE, 
         cluster_rows = F, 
         cluster_cols = FALSE, 
         annotation_names_col = TRUE, 
         annotation_names_row = TRUE, 
         annotation_legend = TRUE,  
         fontsize_row = 18, 
         fontsize = 18, 
         color = my_custom_color,  
         breaks = breaks_list,
         filename = './blue zona.pdf',
         height = 12,width = 15) 
