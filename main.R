# in the name of god
library(dplyr)
library(tidytext)
library(RecordLinkage)
library(stringdist)
library(tidyr)



setwd("~/Documents/datadays/")
td = read.csv("Data/sample_mobile_data_1000.csv", stringsAsFactors = F)
td$id = 1:nrow(td)


desc_token <- td %>% select(id, desc) %>% unnest_tokens(word, desc)
title_token <- td %>% select(id, title) %>% unnest_tokens(word, title)
all_token <- rbind(title_token, desc_token) %>% arrange(id)




brand <- c("iphone", "samsung", "huawei", "آیفون", "سامسونگ")

r <- data.frame()

h <- sapply(brand, function(x) {
  y <- levenshteinSim(all_token$word, x)
  y
})

h <- data.frame(h)

uu <- cbind(all_token, h)

uu <- uu %>% group_by(id)

gather(uu, "brand", "prob", 3:7) %>% arrange(id, word) %>% filter(prob > 0.5) %>% View()
