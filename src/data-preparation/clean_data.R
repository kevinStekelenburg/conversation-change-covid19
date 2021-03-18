# ------- Wordcount (Term Document Matrix creation) -------- 
# INPUT ----
# Load datasets into R
df <- read.csv("./gen/data-preparation/input/dataset_eredivisie.csv")

#VRAAG ME AF OF DEZE STAP LOGISCH IS! ->
# Save dataframe data
save(df,file="./gen/data-preparation/temp/dataframe_eredivisie.RData")

# TRANSFORMATION ----
# installing packages
print("Installing needed packages...")
install.packages("tm",repos = "http://cran.us.r-project.org")
install.packages('syuzhet',repos = "http://cran.us.r-project.org")
install.packages("lubridate",repos = "http://cran.us.r-project.org")
install.packages('scales',repos = "http://cran.us.r-project.org")
install.packages('reshape2',repos = "http://cran.us.r-project.org")

# loading packages
print("Loading packages...")
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)
library(tm)

# loading data for wordcount analysis, storing only the tweets (text) in 'sentiment' variable
wordcount_pre <- df %>% 
  filter(Season=="season19/20")

wordcount_post <- df %>% 
  filter(Season=="season20/21")

#df <- read.csv(file.choose())
print("Cleaning tweets for building a Term Document Matrix (TDM)...")

# change Tweet Text encoding to utf-8 and store in input_corpus
wordcount_pre <- iconv(wordcount_pre$Text, to="utf-8")
wordcount_post <- iconv(wordcount_post$Text, to="utf-8")

# change to corpus file (needed to do analysis)
pre <- Corpus(VectorSource(wordcount_pre))
post <- Corpus(VectorSource(wordcount_post))

# clean text for data analysis
# first: lowercase everything
pre <- tm_map(pre, tolower)
post <- tm_map(post, tolower)

# remove punctuation
pre <- tm_map(pre, removePunctuation)
post <- tm_map(post, removePunctuation)

# remove numbers
pre <- tm_map(pre, removeNumbers)
post <- tm_map(post, removeNumbers)

# remove some common words
pre<- tm_map(pre, removeWords, stopwords('dutch'))
post <- tm_map(post, removeWords, stopwords('dutch'))

# function to remove url's from text
remove_urls <- function(x) gsub('http[[:alnum:]]*', '', x)

# actually removing url's form text
pre <- tm_map(pre, content_transformer(remove_urls))
post <- tm_map(post, content_transformer(remove_urls))

# remove unnecessary blank spaced
pre <- tm_map(pre, stripWhitespace)
post <- tm_map(post, stripWhitespace)

# unstructured text data to structured data by using Term Document Matrix
print("Building TDM for pre-corona and post-corona tweets...")
tdm_pre <- TermDocumentMatrix(pre)
tdm_post <- TermDocumentMatrix(post)

# OUTPUT ----
print("Saving TDM's as csv-files...")
tdm_pre <- as.matrix(tdm_pre)
write.csv(tdm_pre,file="././gen/data-preparation/temp/tdm_pre.csv")
tdm_post <- as.matrix(tdm_post)
write.csv(tdm_post,file="././gen/data-preparation/temp/tdm_post.csv")

# ------- Preparing tweets for sentiment analysis -------
# TRANSFORMATION ----
sentiment_pre <- df %>% 
  filter(Season=="season19/20")

sentiment_post <- df %>% 
  filter(Season=="season20/21")

# loading data for sentiment analysis, storing only the tweets (text) in 'sentiment' variable
sentiment_pre <- iconv(sentiment_pre$Text, to="utf-8")    
sentiment_post <- iconv(sentiment_post$Text, to="utf-8")  

# obtain sentiment scores - store in dataframe: each row is a tweet. 
# scores per tweet for: 
# anger, anticipation, disgust, fear, joy, sadness, surprise, trust, negative & positive.
print("Scoring tweets on various sentiment criteria...")
print("This could take a few moments. Please wait...")
scores_pre <- get_nrc_sentiment(sentiment_pre, language = 'dutch')
scores_post <- get_nrc_sentiment(sentiment_post, language = 'dutch')

# OUTPUT ----
# Save cleaned data
print("Saving 'scored' tweet matrices as Rdata files")
save(scores_pre,file="./gen/data-preparation/output/scores_pre.RData")
save(scores_post,file="./gen/data-preparation/output/scores_post.RData")


