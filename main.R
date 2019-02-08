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




brand <- c("iphone", "samsung", "huawei", "nokia" ,"lenovo", "sony", "lg", "htc" ,"xiaomi", "alcatel", "galaxy", "motorola", "apple", "nexus", "نوکیا", "آیفون", "سامسونگ", "هواوی","ال جی", "سونی", "لنوو","اچ تی سی","شیائومی","الکاتل", "گلکسی", "موتورولا", "اپل")
model <- c("note2","note3","note4","note5","note6","note7","note8","نوت","j1","j2","j3","j4","j5","جی۱","جی۲","جی۳","جی۴","جی۵","s3","s4","s5","s6","s7","s8","s9","اس۳","اس۴","اس۵","اس۶","اس۷","اس۸","اس۹")
mobile_type <- c(brand, model)

dis_brand <- sapply(mobile_type, function(x) {
  y <- levenshteinSim(all_token$word, x)
  y
})

dis_brand <- data.frame(dis_brand)

uu <- cbind(all_token, dis_brand)


gather(uu, "mobile_type", "prob", 3:dim(uu)[2]) %>% arrange(id, word) %>% filter(prob > 0.5) %>% group_by(id) %>% top_n(n = 1) %>% slice(1) %>% View()


