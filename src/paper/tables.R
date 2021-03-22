# Load results
load("./gen/analysis/output/analysis_results.RData")

# Load in additional package to export to latex table

library(stargazer)
library(dplyr)
library(here)
library(ggplot2)

# Export to latex table (omits f-stat since messes up table)
# Heb maar een plot gekozen om het te testen
stargazer(plot_emotions, out="./gen/paper/output/table1.tex",
            title = "Example results", label = "tab:example",
            omit.stat=c("f")) 
