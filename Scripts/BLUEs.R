setwd("/project/dthavar/dilthavar/ssalari/Lentil/Field_study")
df <- read.csv("FD_E5.csv")

head(df)
View (df)

# Convert the first 5 columns to factors
df[,1:6] <- lapply(df[,1:6], as.factor)

df[,7:9] <- lapply(df[,7:9], as.numeric)

x <- trimws(as.character(df[[6]]))
table(is.na(x))
table(x == "NA", useNA = "ifany")
table(x == "", useNA = "ifany")

# fixed-effects model for adjusted means (BLUEs)

library(dplyr)

results <- list()

for(trait in names(df)[7:9]) {
  
  fit <- lm(as.formula(paste(trait, "~ Genotype + Rep + Rep:Block")),
            data = df, na.action = na.exclude)
  
  # Keep only the valid Rep-Block combinations that actually exist
  valid_cells <- unique(df[, c("Rep", "Block")])
  
  # Build all Genotype x (Rep,Block) combinations
  grid <- merge(
    data.frame(Genotype = levels(df$Genotype)),
    valid_cells,
    by = NULL
  )
  
  # Predict adjusted values
  grid$pred <- predict(fit, newdata = grid)
  
  # BLUEs = average predicted value by genotype
  blue <- aggregate(pred ~ Genotype, data = grid, FUN = mean)
  names(blue)[2] <- trait
  
  results[[trait]] <- blue
}

# Put all traits into one table
BLUEs_all <- Reduce(function(x, y) merge(x, y, by = "Genotype", all = TRUE),
                    results)

BLUEs_all



write.csv(BLUEs_all, "BLUEs_FD_E5.csv", row.names = FALSE)



