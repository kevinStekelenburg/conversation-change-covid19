# Download dataset Eredivisie
print("Downloading database...")
download.file('https://www.dropbox.com/s/yklyw87gkflyfwe/merged_tweets_eredivisie.csv?dl=1','././data/dataset_eredivisie.csv')

# Loading great package for dealing with relative path errors
if(!require(here)){
  install.packages('here',repos = "http://cran.us.r-project.org")
  library(here)
}  

# Create GEN directory
print("Creating 'gen' directory...")
dir.create(here("gen"))
dir.create(here("gen", "analysis"))
dir.create(here("gen", "data-preparation"))
dir.create(here("gen", "paper"))
dir.create(here("gen", "analysis", "input"))
dir.create(here("gen", "analysis", "output"))
dir.create(here("gen", "analysis", "temp"))
dir.create(here("gen", "data-preparation", "input"))
dir.create(here("gen", "data-preparation", "output"))
dir.create(here("gen", "data-preparation", "temp"))
dir.create(here("gen", "paper", "input"))
dir.create(here("gen", "paper", "output"))
dir.create(here("gen", "paper", "temp"))



