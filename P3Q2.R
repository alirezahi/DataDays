# in the name of god
library(dplyr)
library(tidytext)
library(devtools)
library(RecordLinkage)
library(tidyr)
library(stringr)

rm(list=ls())

setwd("~/Documents/datadays/")
td <- read.csv("Data/divar_posts_dataset.csv", stringsAsFactors = F, nrows = 3000)

desc_text <- td %>% select(X,desc)

 token_distribution <- desc_text %>%
   unnest_tokens(word, desc) %>%
   group_by(word) %>%
   summarise(count = n()) %>%
   arrange(X,desc(count))

# token_distribution <- desc_text %>%
#   unnest_tokens(word, desc) %>%
#   group_by(X, word) %>%
#   summarise(count = n()) %>%
#   arrange(X,desc(count))
  
# token_distribution_tf_idf <- token_distribution %>%
#   bind_tf_idf(word, X, count) %>% 
#   arrange(X, desc(tf_idf))
