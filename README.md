# The influence of COVID-19 on football conversations

__To what extent did the twitter conversation of Dutch Football fans change due to COVID-19 (no fans in the stadiums)?__

## Motivation
The Covid-19 pandemic has changed the world tremendously. Many places in the world are currently in lockdown and therefore stores, museums, sports clubs and restaurants have been, or are, closed. The Netherlands has experienced several ‘corona waves’ in which the extent of the measures was different. For a while, in the first wave, professional group sports as well as amateur group sports were cancelled completely. Currently, the Netherlands allows group sports without competition for all ages under 27 years old. Next to this, professional players are allowed to play again without public in the stadiums. 

One of the sports that is played the most and attracts the biggest crowds is soccer or football (In Dutch: voetbal. It translates to football but the game is very different from American football. The game is played like British soccer) (Boen, Vanbeselaers & Feys, 2002). In general, Dutch soccer fans are known as very dedicated and enthusiastic (Lechner, 2007). Many soccer fans hold a season ticket and are present at almost every game of their favorite soccer club. The soccer stadiums in the Netherlands can hold up to 56.000 people and are, when not in lockdown, often fully booked. 

As mentioned above, the current covid pandemic has forced fans to stay home and watch soccer on the television. This has created a situation that has almost never occurred in the past and it is therefore very interesting to see how this has impacted soccer fans and their interaction. Normally, the most dedicated fans can express themselves within the stadium but when watching from home, it can well be that they converted some of their interaction to social media and thus the amount of online interaction has gone up. Next to this, we are interested in whether the sentiment in the online interactions changed due to the changed situation. It is intuitive that the sentiment of fans at home is different than when standing in an arena with dozens of enthusiastic and hyped up people. As this research aims to be explorative, no clear hypotheses were generated beforehand. 
As it are hard financial times for football clubs because there are no fans allowed in their stadiums (Grix, Brannagan, Grimes & Neville, 2020), it is vital for soccer clubs to keep their fans engaged with their team. As COVID-19 has shifted face to face interactions to digital interactions, social media is now also the main source of interaction of football clubs with their fans.

The social media platform that is scrapped is Twitter because there is a lot of soccer fan interaction on this platform. Other social media platforms such as Facebook or Instagram are more focused on sharing content whereas twitter is for interacting with one another and giving opinions (Kassing, J. W., & Sanderson, 2010). Twitter also provides several tools for additional interaction because the tweets can be ‘retweeted’ and Tweeters can directly reply on Tweets of other Tweeters. ‘Retweeting’ entails sharing the Tweet someone else created with your own network. 

In general, this dataset was thus created to explore the effects of the Covid-19 measures on the social media interaction of soccer fans. The research question is: To what extent did the twitter conversation of Dutch Football fans change due to COVID-19 (no fans in the stadiums)? The data set contains multiple variables. Next to this, the scraper that was built for this project can easily be adapted to scrape a broader time period than the one that was chosen now. As historical Twitter data cannot be collected from the Application Protocol Interface (API), the scraper that is used is fairly unique in being able to collect historical tweets for free. Because of this, similar data sets are not publicly available. 


## Method and results
Our method consists of 5 steps.

Step 1 - _Data collection_
Step 1 consists of the data collection. That data will be scraped from twitter.com with hashtags of the 18 eredivisie clubs.  The following hashtags were used: #AdoDenHaag #AFCAjax #AZalkmaar #FCEmmen #FCGroningen #FCTwente #FCUtrecht #Feyenoord #FortunaSittard #Heracles #PECZwolle #PSV #RKCWaalwijk #SCHeerenveen #SpartaRotterdam #Vitesse #VVVVenlo #WillemII. Some hashtags (e.g. #ajax) return foreign tweets that are containing this hashtag, but are unrelated to the football club. Therefore, hashtags which resulted in the most related tweets (by observing a sample of tweets) were sought and proved to be the full names of the soccer clubs.
As the research objective is to make a comparison between before Covid-19 and during Covid 19, different weekends were selected to scrape. The weekends selected are:  
Season 2019/2020 (Before Covid-19)
Period 1: Round 14 - 22 23 24 November 2019
Period 2: Round 20 - 24 25 26 January 2020

Season 2020/2021 (During Covid-19)
Period 1: Round 10 - 27 28 29 November 2020
Period 2: Round 18 - 22 23 24 January 2021
These specific weekends were selected because they have a the same amount of games with a similar degree of hypothesized ‘buzz’. With buzz we refer to the degree of rivalry between the soccer clubs and degree of exciting results. 
The entities or instances that are scraped are tweets and the different variables that the tweets contain. The tweets can be from: private individuals, organizations and the soccer teams. For the analysis the variables date, content, unique id and usernames are needed. Next to this, the variables URL, reply count, retweet count, like count, location, user followers count, user friends count and tweet source were scraped. The data is split in a csv file per scraped time period and then merged into one csv file. 

Step 2 - Data Preparation
Step 2 consists of data preperation and cleaning. In this step we preformed some basic cleaning steps. After cleaning the data is ready to be analyzed. 

Step 3 - _Sentiment analysis_

Step 5 - _Presentation of output_
After the data analysis, the data can be visualized. The most important findings are graphically displayed below. 

![image](https://user-images.githubusercontent.com/79858036/112064499-593b1700-8b63-11eb-9040-fcdf0697310f.png)


_First, introduce and motivate your chosen method, and explain how it contributes to solving the research question/business problem.
Second, summarize your results concisely. Make use of subheaders where appropriate._

## Repository overview

_Provide an overview of the directory structure and files._

## Running instructions

_Explain to potential users how to run/replicate your workflow. Touch upon, if necessary, the required input data, which (secret) credentials are required (and how to obtain them), which software tools are needed to run the workflow (including links to the installation instructions), and how to run the workflow. Make use of subheaders where appropriate._

## More resources
__Related documentation__ 
For more information about the scraper used in this study go to:  https://betterprogramming.pub/how-to-scrape-tweets-with-snscrape-90124ed006af or https://github.com/MartinBeckUT/TwitterScraper

More information on online data collections in general? Go to: https://odcm.hannesdatta.com/
More information on data preperation? Go to: https://dprep.hannesdatta.com/
Want to save time and control your empirical research projects? Go to: https://tilburgsciencehub.com/

__Related Literature__

Bond, A. J., Cockayne, D., Ludvigsen, J. A. L., Maguire, K., Parnell, D., Plumley, D., ... & Wilson, R. (2020). COVID-19: the return of football fans. Managing sport and leisure, 1-11.

__References__

Grix, J., Brannagan, P. M., Grimes, H., & Neville, R. (2020). The impact of Covid-19 on sport. International Journal of Sport Policy and Politics, 1-12.

Lechner, F. J. (2007). Imagined communities in the global game: Soccer and the development of Dutch national identity. Global networks, 7(2), 215-229.

Boen, F., Vanbeselaere, N., & Feys, J. (2002). Behavioral consequences of fluctuating group success: An Internet study of soccer-team fans. The Journal of social psychology, 142(6), 769-781.

Kassing, J. W., & Sanderson, J. (2010). Fan–athlete interaction and Twitter tweeting through the Giro: A case study. International journal of sport communication, 3(1), 113-128.

Johnes, M. (2008). We Hate England! We Hate England? National Identity and Anti-Englishness in Welsh Soccer Fan Culture. Soccer Review.

## About

This dataset has been created by Stan Wiggers, Kevin Stekelenburg, Ruben Custers, Eric Volten and Anne van Veenendaal. The dataset has been created on behalf of Tilburg University for the courses Online Data Collection and Management (oDCM) and Data Preparation and Workflow Management (DPrep). 
