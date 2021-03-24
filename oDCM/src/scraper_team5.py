# Scraping Old Tweets of the #eredivisie


# Explanation:
# We will scrape tweets from twitter.com with hashtags of the 18 eredivisie clubs to see if the conversation on twitter changed about football clubs in the Netherlands due to COVID-19

# Dates:
# Season 19/20
# Period 1: Round 14 - 22 23 24 november 2019
# Period 2: Round 20 - 24 25 26 januari 2020

# Season 20/21
# Period 1: Round 10 - 27 28 29 november 2020
# Period 2: Round 18 - 22 23 24 januari 2021

# Hashtags:
# #AdoDenHaag
# #AFCAjax
# #AZalkmaar
# #FCEmmen
# #FCGroningen
# #FCTwente
# #FCUtrecht
# #Feyenoord
# #FortunaSittard
# #Heracles
# #PECZwolle
# #PSV
# #RKCWaalwijk
# #SCHeerenveen
# #SpartaRotterdam
# #Vitesse
# #VVVVenlo
# #WillemII


import sys
import subprocess
import pkg_resources

# check the package installations
required = {'snscrape', 'pandas', 'pathlib', 'regex'}
installed = {pkg.key for pkg in pkg_resources.working_set}
missing = required - installed

print('The following packages are required:')
print(required)

if missing:
    print('The following package(s) is/are missing:')
    print(missing)
    python = sys.executable
    subprocess.check_call(
        [python, '-m', 'pip', 'install', *missing], stdout=subprocess.DEVNULL)
else:
    print('All packages are successfully installed.')

# Imports
import snscrape.modules.twitter as sntwitter
import pandas as pd
from time import sleep
import pathlib
import dropbox
import re
import csv


# Function to scrape tweets
def get_twitterdata(filename,
                    path,
                    season,
                    period,
                    maxTweets = 100,
                    searchq = ['#afcajax'],
                    since = '2021-01-01', until='2021-01-03'):

    # Begin with X tweets to search in order to see if it works without taking too much time
    timefilter= 'since:' + since +' until:'+until
    print("Hi! I'm starting up!")
    print('for time period: '+ timefilter)
    # Creating list to append tweet data to
    tweets_list1 = []

    # Using SNScraper to scrape data and append tweets to list

    for i,tweet in enumerate(sntwitter.TwitterSearchScraper(searchq + ' ' + timefilter).get_items()):
        if i>maxTweets: #stops when amount of tweets is at its maximum
            break

        tweets_list1.append([season, period, tweet.url, tweet.date, tweet.id, tweet.content, tweet.user.username, tweet.replyCount, tweet.retweetCount, tweet.likeCount, tweet.user.location, tweet.user.followersCount, tweet.user.friendsCount, tweet.source]) #add all the items we want to subtrect
    print('Done scraping! Saving now :)')

    # Creating a dataframe from the tweets list above
    df_tweets1 = pd.DataFrame(tweets_list1, columns=['Season', 'Period','URL', 'Datetime', 'Tweet Id', 'Text', 'Username', 'Replies', 'Retweets', 'Likes', 'Location', 'Followers', 'Friends', 'Source']) #give the collumns names and create our Data Frame
    df_tweets1.to_csv(path + filename, sep=',', index=False)

    print(f'Done with data from {season} {period}!')

eredivisie_clubs='#AdoDenHaag OR #AFCAjax OR #AZalkmaar OR #FCEmmen OR #FCGroningen OR #FCTwente OR #FCUtrecht OR #Feyenoord OR #FortunaSittard OR #Heracles OR #PECZwolle OR #PSV OR #RKCWaalwijk OR #SCHeerenveen OR #SpartaRotterdam OR #Vitesse OR #VVVVenlo OR #WillemII'
data_path="../../oDCM/data/",

# Now scraping tweets for Eredivisie Hashtags, Season X and Period X
# Season 19/20, period 1
get_twitterdata(filename= 'season19-20period1max100.csv',
                path= "../../oDCM/data/",
                searchq= eredivisie_clubs,
                since = '2019-11-22',
                until = '2019-11-24',
                season= 'season19/20',
                period= 'period1')

sleep(5)

# Season 19/20, period 2
get_twitterdata(filename= 'season19-20period2max100.csv',
                path= "../../oDCM/data/",
                searchq= eredivisie_clubs,
                since = '2020-01-24',
                until = '2020-01-26',
                season= 'season19/20',
                period= 'period2')

sleep(5)

# Season 20/21, period 1
get_twitterdata(filename= 'season20-21period1max100.csv',
                path= "../../oDCM/data/",
                searchq= eredivisie_clubs,
                since = '2020-11-27',
                until = '2020-11-29',
                season= 'season20/21',
                period= 'period1')

sleep(5)

# Season 20/21, period 2
get_twitterdata(filename= 'season20-21period2max100.csv',
                path= "../../oDCM/data/",
                searchq= eredivisie_clubs,
                since = '2021-01-22',
                until = '2021-01-24',
                season= 'season20/21',
                period= 'period2')

print("all done! :)")


# Now merging and exporting local

Find_All_CSVs = ['season19-20period1max100.csv',
                 'season19-20period2max100.csv',
                 'season20-21period1max100.csv',
                 'season20-21period2max100.csv']

#combining all files in the list

combined_csv = pd.concat([pd.read_csv(f,header=0) for f in Find_All_CSVs])

combined_csv.head()

combined_csv.to_csv("..\..\oDCM\data\merged_tweets_eredivisiemax100.csv", quotechar='"',
          quoting=csv.QUOTE_ALL, index=False, encoding='utf-8')

print("all done merging! twitter data available in your directory")


# Now exporting to Dropbox

#class TransferData:
#    def __init__(self, access_token):
#        self.access_token = access_token

#    def upload_file(self, file_from, file_to):
#        """upload a file to Dropbox using API v2
#        """
#        dbx = dropbox.Dropbox(self.access_token)

#        with open(file_from, 'rb') as f:
#            dbx.files_upload(f.read(), file_to)

#def main():
#    access_token = 'v-mXjquqVYUAAAAAAAAAASK_JKxBrPRCHBuXOIP4_Nb7dTKnklglKe0JQU2hH6WC'
#    transferData = TransferData(access_token)

#    file_from = 'merged_tweets_eredivisie.csv'
#    file_to = '/Apps/dPrep/merged_tweets_eredivisie.csv'  # The full dropbox path to upload the file to, including the file name

    # API v2
#    transferData.upload_file(file_from, file_to)

#if __name__ == '__main__':
#    main()

#print("All done, check out the dropbox folder: ")
