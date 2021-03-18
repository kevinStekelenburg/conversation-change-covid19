# this file is used for merging the output dataframes "pre" and "post" which scores each tweet on different criteria
# INPUT ----
print("Reading pre- and post-corona dataframes for sentiment analysis...")

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
load(file=here("gen", "data-preparation", "output", "scores_pre.Rdata"))
load(file=here("gen", "data-preparation", "output", "scores_post.Rdata"))


