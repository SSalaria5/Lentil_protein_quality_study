# Load required libraries
library(rstanarm)
library(bayesplot)
library(shinystan)

setwd("/project/dthavar/dilthavar/ssalari/Lentil/Field_study")

# Read your data
df <- read.csv("Field_data_analysis_file.csv")
head(df)
# Convert the first 5 columns to factors
df[,1:7] <- lapply(df[,1:7], as.factor)

# Make sure trait columns are numeric
df[, c("Protein", "SAAs", "PDg")] <- lapply(df[, c("Protein", "SAAs", "PDg")], as.numeric)


# Start with just Genotype column
Lens_FD_alldata_bayesblups <- unique(df[, "Genotype", drop = FALSE])

# Loop over traits
for (trait in c("Protein", "SAAs", "PDg")) {
  
  stan.model <- stan_lmer(
    paste0(trait, " ~ (1|Genotype) + (1|Env) + (1|Genotype:Env) + (1|Rep:Env) + (1|Block:Rep:Env)"), 
    data = df, adapt_delta = 0.99, seed = 324
  )
  
  blups <- ranef(stan.model)$Genotype
  blups$Genotype <- rownames(blups)
  colnames(blups) <- c(trait, "Genotype")
  
  Lens_FD_alldata_bayesblups <- merge(Lens_FD_alldata_bayesblups, blups, by = "Genotype")
}

# Save results
write.csv(unique(Lens_FD_alldata_bayesblups), "Lens_FD_alldata_bayesblups.csv", row.names = FALSE, quote = FALSE)
