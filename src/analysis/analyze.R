# INPUT ----
# Loading in the csv's from preparation stage
library(dplyr)
library(here)
library(ggplot2)
tdm_pre <- read.csv(here("gen", "analysis", "input", "tdm_pre.csv"))
tdm_post <- read.csv(here("gen", "analysis", "input", "tdm_post.csv"))
merged_sentiment <- read.csv(here("gen", "analysis", "input", "merged_sentiment.csv"))

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

# Preparing for plot - wordcount
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
# only selecting words occuring more than 150 times to strip out irrelevant words.
w_merged <- filter(w_merged, count>150)

# Creating barplot - wordcount (exploration)
plot_wordcount <- ggplot(w_merged, aes(x=word, y=count, fill=season))+
  geom_col(position=position_dodge(width=1))+
  coord_flip()+
  scale_fill_manual(values = c("#606060", "#B3B3B3"))

# Preparing for plot of sums - sentiment analysis (exploration)
merged_sentiment_sum <- merged_sentiment %>% 
  group_by(season) %>% 
  summarize(anger=sum(anger),
            anticipation=sum(anticipation),
            disgust=sum(disgust),
            fear=sum(fear),
            joy=sum(joy),
            sadness=sum(sadness),
            surprise=sum(surprise),
            trust=sum(trust),
            negative=sum(negative),
            positive=sum(positive)) %>% 
  tidyr::gather("emotion", "count", -season)

# Creating plot for sentiment
plot_emotions <- filter(merged_sentiment_sum, emotion != "positive" & emotion != "negative") %>% 
  ggplot(aes(x=emotion, y=count, fill=season))+
  geom_col(position=position_dodge(width=1))+
  scale_fill_manual(values = c("#606060", "#B3B3B3"))

plot_posneg <- filter(merged_sentiment_sum, emotion == "positive" | emotion == "negative") %>% 
  ggplot(aes(x=emotion, y=count, fill=season))+
  geom_col(position=position_dodge(width=1))+
  scale_fill_manual(values = c("#606060", "#B3B3B3"))

# ACTUAL ANALYSIS FOR PAPER


# OUTPUT ----
# Saving plots and outputs
print("Saving plots in pdf-file...")
save(plot_wordcount, plot_emotions, plot_posneg, file = here("gen", "analysis", "output", "analysis_results.RData"))

pdf(here("gen", "analysis", "output", "plot_wordcount_sum.pdf"))
print(plot_wordcount)
dev.off()

pdf(here("gen", "analysis", "output", "plot_emotions_sum.pdf"))
print(plot_emotions)
dev.off()

pdf(here("gen", "analysis", "output", "plot_posneg_sum.pdf"))
print(plot_posneg)
dev.off()

print("Done saving plots in pdf!")