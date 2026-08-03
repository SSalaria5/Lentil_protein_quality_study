library(GAPIT)

setwd("/project/dthavar/dilthavar/ssalari/Lentil/Field_study")
myY <- read.csv("Lens_FD_Y1_bayesblups.csv", header = TRUE)
myY$Genotype <- as.character(myY$Genotype)
head(myY)

# Genotypic data
setwd("/scratch/ssalari/LentilHudsonALphaWGS-analyses/Lensseq/filtered_vcfs/Final_file")
myG <- read.delim(file="Lentil_LAMP_vcf_MAF_0.05_Miss_0.2_hapmap.txt",header = F) #sep="\t"
head(myG)

setwd ("/project/dthavar/dilthavar/ssalari/Lentil/Field_study/Final_GWAS/combined_BLUPs/Protein")
myGAPIT = GAPIT(
  Y = myY[,c("Genotype","Protein")],
  G = myG,
  PCA.total = 5,
  model = c("BLINK", "FarmCPU", "MLM", "GLM", "MLMM", "CMLM"),
  SNP.MAF = 0.05,
  SNP.FDR = 0.05,
  kinship.algorithm = "VanRaden"
)

# SUPER_model##
myGAPIT_SUPER=GAPIT(
  Y=myY[,c("Genotype","Protein")], #fist column is ID
  G=myG,
  PCA.total=5,
  model=c("SUPER"),
  SNP.MAF=0.05,
  SNP.FDR=0.05,
  kinship.algorithm = "VanRaden")


