library(RColorBrewer)
library(ggplot2)
setwd("/project/dthavar/dilthavar/ssalari/Lentil/PCA")
PCA <- read.csv("Genotypic_PCA.csv", header = TRUE)
head(PCA)

#PCA Origin
PCA$Origin <- as.factor(PCA$Origin_continent)
ggplot(PCA, aes(PC1, PC2, shape=Origin_continent, color=Origin_continent)) +
  geom_point(size = 2, show.legend = TRUE) +
  scale_color_brewer(palette = "Set1") +
  scale_shape_manual (values = c(9, 12, 10, 11, 12, 13)) +  # Specify shapes for 9 subpopulations
  theme_bw() +
  theme(panel.grid.minor = element_blank())




# Plot with manually specified shapes and color
ggplot(PCA, aes(PC1, PC2, shape = Subpopulation, color = Subpopulation)) +
  geom_point(size = 2, show.legend = TRUE) +
  scale_color_brewer(palette = "RdYlGn") +
  scale_shape_manual (values = c(11, 12, 1, 8, 15, 16, 17, 22, 6, 5)) +  # Specify shapes for 9 subpopulations
  theme_bw() +
  theme(panel.grid.minor = element_blank())




