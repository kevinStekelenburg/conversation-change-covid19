# Libraries
library(here)
library(dplyr)
library(ggplot2)

# Load results
load(here("gen", "analysis", "output", "analysis_results.RData"))

# Generating plots
print("Generating all plots as pdf...")

pdf(here("gen", "analysis", "output", "plot_wordcount_sum.pdf"))
print(plot_wordcount)
dev.off()

pdf(here("gen", "analysis", "output", "plot_emotions_sum.pdf"))
print(plot_emotions)
dev.off()

pdf(here("gen", "analysis", "output", "plot_posneg_sum.pdf"))
print(plot_posneg)
dev.off()

pdf(here("gen", "analysis", "output", "boxplot_anger.pdf"))
print(bxp_anger)
dev.off()

pdf(here("gen", "analysis", "output", "boxplot_anticipation.pdf"))
print(bxp_anticipation)
dev.off()

pdf(here("gen", "analysis", "output", "boxplot_disgust.pdf"))
print(bxp_disgust)
dev.off()

pdf(here("gen", "analysis", "output", "boxplot_fear.pdf"))
print(bxp_fear)
dev.off()

pdf(here("gen", "analysis", "output", "boxplot_joy.pdf"))
print(bxp_joy)
dev.off()

pdf(here("gen", "analysis", "output", "boxplot_positive.pdf"))
print(bxp_positive)
dev.off()

pdf(here("gen", "analysis", "output", "boxplot_negative.pdf"))
print(bxp_negative)
dev.off()

pdf(here("gen", "analysis", "output", "boxplot_sadness.pdf"))
print(bxp_sadness)
dev.off()

pdf(here("gen", "analysis", "output", "boxplot_surprise.pdf"))
print(bxp_surprise)
dev.off()

pdf(here("gen", "analysis", "output", "boxplot_trust.pdf"))
print(bxp_trust)
dev.off()

if(!require(gridExtra)){
  install.packages("gridExtra",repos = "http://cran.us.r-project.org")
  library(gridExtra)
}

# Generating table pdf's
pdf(here("gen", "analysis", "output", "t_test_table.pdf"), height=11, width=10)
grid.table(t_tests)
dev.off()

pdf(here("gen", "analysis", "output", "descriptives.pdf"), height=11, width=10)
grid.table(descriptives)
dev.off()
