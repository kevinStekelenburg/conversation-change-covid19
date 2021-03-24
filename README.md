# The influence of COVID-19 on football conversations

__To what extent did the twitter conversation of Dutch Football fans change due to COVID-19 (no fans in the stadiums)?__

## Motivation
The Covid-19 pandemic has changed the world tremendously. The Netherlands has experienced several ‘corona waves’ in which the extent of the measures was different. For a while, in the first wave, professional group sports as well as amateur group sports were cancelled completely. Currently, professional players are allowed to play again without public in the stadiums. One of the sports that is played the most and attracts the biggest crowds is soccer or football (Boen, Vanbeselaers & Feys, 2002). In general, Dutch soccer fans are known as very dedicated (Lechner, 2007). Many soccer fans hold a season ticket and are present at almost every game of their favorite soccer club. The soccer stadiums in the Netherlands can hold up to 56.000 people and are, when not in lockdown, often fully booked. Not having public in the stadiums makes it hard for the soccer clubs financially. It is vital for the soccer clubs that their fans will remain engaged even though they cannot be physically present. 

__This research:__

* Takes Twitter as the social media platform for data collection. On this platform there is a lot of soccer fan interaction both between fans and with the teams. Other social media platforms such as Facebook or Instagram are more focused on sharing content whereas twitter is for interacting with one another and giving opinions (Kassing, J. W., & Sanderson, 2010). Twitter also provides several tools for additional interaction because the tweets can be ‘retweeted’ and Tweeters can directly reply on Tweets of other Tweeters. ‘Retweeting’ entails sharing the Tweet someone else created with your own network. 

* Has the following research question: To what extent did the twitter conversation of Dutch Football fans change due to COVID-19 (no fans in the stadiums)?

* Evaluates whether some of the interaction between fans that would normally have in the stadium has transferred to online interaction. So the research looked at whether the amount of tweets has gone up. 

* The researches evaluates whether the sentiment in the online interactions changed due to the changed situation. It is intuitive that the sentiment of fans at home is different than when standing in an arena with dozens of enthusiastic and hyped up people. 

* Uses a scraper that can easily be adapted to scrape a broader time period than the one that was chosen in this study. The snscraper is used to webscrape the tweets because  historical Twitter data cannot be collected from the Application Protocol Interface (API). 


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

Step 2 - _Data Preparation_

Step 2 consists of data preperation and cleaning. In this step we preformed some basic cleaning steps. After cleaning the data is ready to be analyzed. 

Step 3 - _Analysis_
_First, introduce and motivate your chosen method, and explain how it contributes to solving the research question/business problem.
Step 5 - _Presentation of output_

In the plot below one can find an overview of the amount of tweets per hashtag per period. As visualized in the plot, Feyenoord and PSV are especially popular on Twitter during the selected timeframe as they are mentioned the most. 
  
![image](https://user-images.githubusercontent.com/79858036/112386731-9b925e80-8cf1-11eb-879b-6f7723ef768d.png)

For the sentiment analysis, a new dataset was created that counts the amount of words that contain the emotions: anger, anticipation, disgust, fear, joy, sadness, surprise and trust. Next to the emotions, tweets were evaluated on negativity and positivity. The count per variable per period is displayed in the graph below. 

![image](https://user-images.githubusercontent.com/79858036/112387040-c11f6800-8cf1-11eb-8a28-0b5b3929ae16.png)
 
To see whether there are significant difference in sentiment pre and post corona, several independent sample T-tests were performed. In the table below, one can find an overview of the summary statistics per emotion and on negativity and positivity. Next to this, the outcomes of the independent sample T-test are displayed. 
  
As already evident in the table, there are significant effects detected for several variables. An interesting observation is that there are more negative words in the tweets during corona than before corona. Next to this, less positivity was detected in tweets during games in Covid-19 times. 
 
![image](https://user-images.githubusercontent.com/79858036/112387324-e90ecb80-8cf1-11eb-8d1f-6113786e1f20.png)



## Repository overview

_Provide an overview of the directory structure and files._

## Running instructions

Several packages should be installed in order to run this pipeline: 
For the scraper, install: 
Install Python

Anaconda is recommended. Download Anaconda.
check availability: type anaconda --version in the command line.

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
