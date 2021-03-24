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

# <- misschien hieronder code voor only install if package missing
install.packages('ggpubr')
install.packages('rstatix')
library(ggpubr)
library(rstatix)

# descriptive statistics
stat_anger <- merged_sentiment %>%
  group_by(season) %>%
  get_summary_stats(anger, type = "mean_sd")

stat_anticipation <- merged_sentiment %>%
  group_by(season) %>%
  get_summary_stats(anticipation, type = "mean_sd")

stat_disgust <- merged_sentiment %>%
  group_by(season) %>%
  get_summary_stats(disgust, type = "mean_sd")

stat_fear <- merged_sentiment %>%
  group_by(season) %>%
  get_summary_stats(fear, type = "mean_sd")

stat_joy <- merged_sentiment %>%
  group_by(season) %>%
  get_summary_stats(joy, type = "mean_sd")

stat_sadness <- merged_sentiment %>%
  group_by(season) %>%
  get_summary_stats(sadness, type = "mean_sd")

stat_surprise <- merged_sentiment %>%
  group_by(season) %>%
  get_summary_stats(surprise, type = "mean_sd")

stat_trust <- merged_sentiment %>%
  group_by(season) %>%
  get_summary_stats(trust, type = "mean_sd")

stat_negative <- merged_sentiment %>%
  group_by(season) %>%
  get_summary_stats(negative, type = "mean_sd")

stat_positive <- merged_sentiment %>%
  group_by(season) %>%
  get_summary_stats(positive, type = "mean_sd")

# Creating df containing descriptives of all variables per group (season)
descriptives <- bind_rows(list(stat_anger, stat_anticipation, stat_disgust,
                               stat_fear, stat_joy, stat_sadness, stat_surprise,
                               stat_trust, stat_negative, stat_positive))

# Independent t-tests for comparing groups
t_anger <- merged_sentiment %>% 
  t_test(anger ~ season) %>%
  add_significance()

t_anticipation <- merged_sentiment %>% 
  t_test(anticipation ~ season) %>%
  add_significance()

t_disgust <- merged_sentiment %>% 
  t_test(disgust ~ season) %>%
  add_significance()

t_fear <- merged_sentiment %>% 
  t_test(fear ~ season) %>%
  add_significance()

t_joy <- merged_sentiment %>% 
  t_test(joy ~ season) %>%
  add_significance()

t_sadness <- merged_sentiment %>% 
  t_test(sadness ~ season) %>%
  add_significance()

t_surprise <- merged_sentiment %>% 
  t_test(surprise ~ season) %>%
  add_significance()

t_trust <- merged_sentiment %>% 
  t_test(trust ~ season) %>%
  add_significance()

t_negative <- merged_sentiment %>% 
  t_test(negative ~ season) %>%
  add_significance()

t_positive <- merged_sentiment %>% 
  t_test(positive ~ season) %>%
  add_significance()

# Creating df containing t-tests of all variables
t_tests <- bind_rows(list(t_anger, t_anticipation, t_disgust,
                               t_fear, t_joy, t_sadness, t_surprise,
                               t_trust, t_negative, t_positive))

# Creating boxplots for t-test
# Relationship corona - Anger in tweets
bxp_anger <- ggboxplot(
  merged_sentiment, x = "season", y = "anger", 
  ylab = "Anger", xlab = "Season", add = "jitter"
)

stat.test <- t_anger %>% add_xy_position(x = "season")
bxp_anger <- bxp_anger + 
  stat_pvalue_manual(stat.test, tip.length = 0) +
  labs(subtitle = get_test_label(stat.test, detailed = TRUE))

# Relationship corona - Anticipation in tweets
bxp_anticipation <- ggboxplot(
  merged_sentiment, x = "season", y = "anticipation", 
  ylab = "Anticipation", xlab = "Season", add = "jitter"
)

stat.test <- t_anticipation %>% add_xy_position(x = "season")
bxp_anticipation <-bxp_anticipation + 
  stat_pvalue_manual(stat.test, tip.length = 0) +
  labs(subtitle = get_test_label(stat.test, detailed = TRUE))

# Relationship corona - Disgust in tweets
bxp_disgust <- ggboxplot(
  merged_sentiment, x = "season", y = "disgust", 
  ylab = "Disgust", xlab = "Season", add = "jitter"
)

stat.test <- t_disgust %>% add_xy_position(x = "season")
bxp_disgust <- bxp_disgust + 
  stat_pvalue_manual(stat.test, tip.length = 0) +
  labs(subtitle = get_test_label(stat.test, detailed = TRUE))

# Relationship corona - Fear in tweets
bxp_fear <- ggboxplot(
  merged_sentiment, x = "season", y = "fear", 
  ylab = "Fear", xlab = "Season", add = "jitter"
)

stat.test <- t_fear %>% add_xy_position(x = "season")
bxp_fear <- bxp_fear + 
  stat_pvalue_manual(stat.test, tip.length = 0) +
  labs(subtitle = get_test_label(stat.test, detailed = TRUE))

# Relationship corona - Joy in tweets
bxp_joy <- ggboxplot(
  merged_sentiment, x = "season", y = "joy", 
  ylab = "Joy", xlab = "Season", add = "jitter"
)

stat.test <- t_joy %>% add_xy_position(x = "season")
bxp_joy <- bxp_joy + 
  stat_pvalue_manual(stat.test, tip.length = 0) +
  labs(subtitle = get_test_label(stat.test, detailed = TRUE))

# Relationship corona - Sadness in tweets
bxp_sadness <- ggboxplot(
  merged_sentiment, x = "season", y = "sadness", 
  ylab = "Sadness", xlab = "Season", add = "jitter"
)

stat.test <- t_sadness %>% add_xy_position(x = "season")
bxp_sadness <- bxp_sadness + 
  stat_pvalue_manual(stat.test, tip.length = 0) +
  labs(subtitle = get_test_label(stat.test, detailed = TRUE))

# Relationship corona - Surprise in tweets
bxp_surprise <- ggboxplot(
  merged_sentiment, x = "season", y = "surprise", 
  ylab = "Surprise", xlab = "Season", add = "jitter"
)

stat.test <- t_surprise %>% add_xy_position(x = "season")
bxp_surprise <- bxp_surprise + 
  stat_pvalue_manual(stat.test, tip.length = 0) +
  labs(subtitle = get_test_label(stat.test, detailed = TRUE))

# Relationship corona - Trust in tweets
bxp_trust <- ggboxplot(
  merged_sentiment, x = "season", y = "trust", 
  ylab = "Trust", xlab = "Season", add = "jitter"
)

stat.test <- t_trust %>% add_xy_position(x = "season")
bxp_trust <- bxp_trust + 
  stat_pvalue_manual(stat.test, tip.length = 0) +
  labs(subtitle = get_test_label(stat.test, detailed = TRUE))

# Relationship corona - Negative in tweets
bxp_negative <- ggboxplot(
  merged_sentiment, x = "season", y = "negative", 
  ylab = "Negative", xlab = "Season", add = "jitter"
)

stat.test <- t_negative %>% add_xy_position(x = "season")
bxp_negative <- bxp_negative + 
  stat_pvalue_manual(stat.test, tip.length = 0) +
  labs(subtitle = get_test_label(stat.test, detailed = TRUE))

# Relationship corona - Positive in tweets
bxp_positive <- ggboxplot(
  merged_sentiment, x = "season", y = "positive", 
  ylab = "Positive", xlab = "Season", add = "jitter"
)

stat.test <- t_positive %>% add_xy_position(x = "season")
bxp_positive <- bxp_positive + 
  stat_pvalue_manual(stat.test, tip.length = 0) +
  labs(subtitle = get_test_label(stat.test, detailed = TRUE))

# OUTPUT ----
# Saving plots and outputs
print("Saving plots in pdf-file...")
save(plot_wordcount, plot_emotions, plot_posneg, t_tests, 
     descriptives, bxp_anger, bxp_anticipation, bxp_disgust, bxp_fear, bxp_joy, bxp_sadness,
     bxp_surprise, bxp_trust, bxp_negative, bxp_positive,
     file = here("gen", "analysis", "output", "analysis_results.RData"))

print("Done saving plots in pdf!")