# Copy output from data-preparation into input folder 
file.copy(here("gen", "data-preparation", "output", "tdm_post.csv"), here("gen", "analysis", "input", "tdm_post.csv"))
file.copy(here("gen", "data-preparation", "output", "tdm_pre.csv"), here("gen", "analysis", "input", "tdm_pre.csv"))
file.copy(here("gen", "data-preparation", "output", "merged_sentiment.csv"), here("gen", "analysis", "input", "merged_sentiment.csv"))
