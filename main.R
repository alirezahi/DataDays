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




brand <- c("iphone", "samsung", "huawei", "nokia" ,"lenovo", "sony", "lg", "htc" ,"xiaomi", "alcatel", "galaxy", "motorola", "نوکیا", "آیفون", "سامسونگ", "هواوی","ال جی", "سونی", "لنوو","اچ تی سی","شیائومی","الکاتل", "گلکسی", "موتورولا")


dis_brand <- sapply(brand, function(x) {
  y <- levenshteinSim(all_token$word, x)
  y
})

dis_brand <- data.frame(dis_brand)

uu <- cbind(all_token, dis_brand)


gather(uu, "brand", "prob", 3:26) %>% arrange(id, word) %>% filter(prob > 0.5) %>% group_by(id) %>% top_n(n = 1) %>% slice(1) %>% View()


