# INPUT ----
# Loading in the csv's from preparation stage
library(dplyr)
library(here)
library(ggplot2)
tdm_pre <- read.csv(here("gen", "analysis", "input", "tdm_pre.csv"))
tdm_post <- read.csv(here("gen", "analysis", "input", "tdm_post.csv"))
mered_sentiment <- read.csv(here("gen", "analysis", "input", "merged_sentiment.csv"))

# TRANSFORMATION ----
# wordcount of the tweets tweets in both Term Document Matrices
print("Creating plots for most occuring words in pre- and post-corona tweets...")

# THIS CODE IS FOR CREATING A TABLE WITH COLUMS: WORD, COUNT_PRE, COUNT_POST <-- UNCOMMENT TO CREATE

# w_pre <- tdm_pre %>% 
#   mutate(count = rowSums(tdm_pre[,-1])) %>% 
#   select(1, last_col()) %>% 
#   rename(word=X)
# 
# w_post <- tdm_post %>% 
#   mutate(count = rowSums(tdm_post[,-1])) %>% 
#   select(1, last_col()) %>% 
#   rename(word=X)
# 
# w_merged <- inner_join(w_pre, w_post, by="word", suffix = c("_pre", "_post")) %>%
#   filter(count_pre>100 | count_post>100)

w_pre <- tdm_pre %>% 
  mutate(count = rowSums(tdm_pre[,-1])) %>% 
  select(1, last_col()) %>% 
  rename(word=X) %>% 
  mutate(season="pre")

w_post <- tdm_post %>% 
  mutate(count = rowSums(tdm_post[,-1])) %>% 
  select(1, last_col()) %>% 
  rename(word=X) %>% 
  mutate(season="post")

w_merged <- bind_rows(w_pre, w_post)
w_merged <- filter(w_merged, count>150)

# creating barplots
plot_wordcount <- ggplot(w_merged, aes(x=word, y=count, fill=season))+
  geom_col(position=position_dodge(width=1))+
  coord_flip()+
  scale_fill_manual(values = c("#bbe3b3", "#e3bab3"))+
  ggtitle("Count of words used in tweets", subtitle="For words occuring at least 150 times pre-corona or post-corona")

# OUTPUT ----
# Saving plots and outputs
print("Saving plots in pdf-file...")
pdf(here("gen", "analysis", "output", "plots.pdf"))
print(plot_wordcount)
dev.off()

print("Done.")