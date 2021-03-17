# Load datasets into R 
df <- read.csv("./gen/data-preparation/input/dataset_eredivisie.csv")

# Save dataframe data
save(df,file="./gen/data-preparation/temp/dataframe_eredivisie.RData")

#clean the text


df_cleaned <- df

# Save cleaned data
save(df_cleaned,file="./gen/data-preparation/output/data_cleaned.RData")
