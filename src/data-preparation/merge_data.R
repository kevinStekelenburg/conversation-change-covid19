# this file is used for merging the output dataframes "pre" and "post" which scores each tweet on different criteria
# INPUT ----
print("Reading pre- and post-corona dataframes for sentiment analysis...")

library(here)
library(dplyr)
load(file=here("gen", "data-preparation", "temp", "scores_pre.Rdata"))
load(file=here("gen", "data-preparation", "temp", "scores_post.Rdata"))

# TRANSFORMATION ----
# adding columns indicating pre- or postcorona

print("Adding column indicating pre- or post-corona; merging two datasets...")
scores_pre <- scores_pre %>% 
  mutate(season="pre")

scores_post <- scores_post %>% 
  mutate(season="post")
  
# combining rows of datasets
merged_sentiment <- bind_rows(scores_pre, scores_post)

# OUTPUT ----
print("Saving merged dataset for sentiment analysis as csv...")
write.csv(merged_sentiment,file=here("gen", "data-preparation", "output", "merged_sentiment.csv"))
save(merged_sentiment,file=here("gen", "data-preparation", "temp", "merged_sentiment.RData"))