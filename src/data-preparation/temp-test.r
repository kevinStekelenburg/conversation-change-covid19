df <- read.csv(file.choose())

# loading library for natural language processing (NLP, text analysis) - only when not installed
if(!require(tm)){
  install.packages("tm")
  library(tm)
}

# change encoding to utf-8 and store in input_corpus
input_corpus <- iconv(df$Text, to="utf-8")

# change to corpus file (needed to do analysis)
corpus <- Corpus(VectorSource(input_corpus))

# Inspecting corpus file
inspect(corpus[1:5])

# clean text for data analysis
# first: lowercase everything
corpus <- tm_map(corpus, tolower)

# remove punctuation
corpus <- tm_map(corpus, removePunctuation)

# remove numbers
corpus <- tm_map(corpus, removeNumbers)

# remove some common words
corpus <- tm_map(corpus, removeWords, stopwords('dutch'))

# function to remove url's from text
remove_urls <- function(x) gsub('http[[:alnum:]]*', '', x)

# actually removing url's form text
corpus <- tm_map(corpus, content_transformer(remove_urls))

# remove unnecessary blank spaced
corpus <- tm_map(corpus, stripWhitespace)
clean_corp <- corpus

# unstructured text data to structured data by using term document matrix
tdm <- TermDocumentMatrix(clean_corp)
tdm <- as.matrix(tdm)

# wordcount of all tweets
w <- rowSums(tdm)
w <- subset(w, w>=100)

# barplot of words counted in all tweets
barplot(w,
        las=2,
        col = rainbow(50))

# wordcloud library to present wordfrequency in wordcloud
library(wordcloud)

# creating wordcloud
wordcloud(words=names(w),
          freq=w,
          max=100)

# ------- Sentiment analysis --------#
# installing packages
install.packages('syuzhet')
install.packages("lubridate")
install.packages('scales')
install.packages('reshape2')

# loading packages
library(syuzhet)
library(lubridate)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

# loading data for sentiment analysis, storing only the tweets (text) in 'sentiment' variable
sentiment_pre <- df %>% 
  filter(Season=="season19/20")

sentiment_post <- df %>% 
  filter(Season=="season20/21")

sentiment_pre <- iconv(sentiment_pre$Text, to="utf-8")    
sentiment_post <- iconv(sentiment_post$Text, to="utf-8")  

# obtain sentiment scores - store in dataframe: each row is a tweet. 
# scores per tweet for: 
# anger, anticipation, disgust, fear, joy, sadness, surprise, trust, negative & positive.
scores_pre <- get_nrc_sentiment(sentiment_pre, language = 'dutch')
scores_post <- get_nrc_sentiment(sentiment_post, language = 'dutch')

#plot the results
barplot(colSums(scores_pre),
        las=2,
        ylab='count',
        col= rainbow(10),
        main='sentiment scores pre-corona')

barplot(colSums(scores_post),
        las=2,
        ylab='count',
        col= rainbow(10),
        main='sentiment scores post-corona')

library(data.table)

pre <-  colSums(scores_pre)
post <- colSums(scores_post)

pre <- as.matrix(pre)
post <- as.matrix(post)
total <- bind_cols(pre, post) 



  