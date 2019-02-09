# in the name of god
library(dplyr)
library(tidytext)
library(RecordLinkage)
library(stringdist)
library(tidyr)
library(plyr)

title_prob_precision <- 0.8
all_token_prob_precision <- 0.5

setwd("~/Documents/datadays/")
td = read.csv("Data/sample_mobile_data_1000.csv", stringsAsFactors = F)
td$id = 1:nrow(td)


desc_token <- td %>% select(id, desc) %>% unnest_tokens(word, desc)
title_token <- td %>% select(id, title) %>% unnest_tokens(word, title)
all_token <- rbind(title_token, desc_token) %>% arrange(id)


model <- c(c("iphone", "samsung", "huawei", "nokia" ,"lenovo", "sony", "lg", "htc" ,"xiaomi", "alcatel", "galaxy", "motorola", "apple", "نوکیا", "آیفون", "سامسونگ", "هواوی","الجی", "سونی", "لنوو","اچ تی سی","شیائومی","الکاتل", "گلکسی", "موتورولا", "اپل"), "note2","note3","note4","note5","note6","note7","note8","۲نوت۸","نوت۷","نوت۶","نوت۵","نوت۴","نوت۳","نوت۹","نوت","j1","j2","j3","j4","j5","j6","j7","جی۱","جی۲","جی۳","جی۴","جی۵","جی۶","جی۷","s3","s4","s5","s6","s7","s8","s9","اس۳","اس۴","اس۵","اس۶","اس۷","اس۸","اس۹","z1","z10","lumia","a5","a6","a7","honor","nexus5", "nexus5x", "nexus6p", "nexus4", "nexus7", "نکسوس۵","نکسوس۵ایکس","نکسوس۴","نکسوس۷", "zte","caterpillar","کاترپیلار","desire","دیزایر","زیمنس","siemens","هانر","g610","g620","g630")
brand <- c("apple", "samsung", "huawei", "nokia", "lenovo", "sony", "lg", "htc", "xiaomi", "alcatel", "samsung", "motorola", "apple", "nokia", "apple", "samsung", "huawei", "lg", "sony", "lenovo", "htc", "xiaomi", "alcatel", "samsung", "motorola","apple", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "samsung", "sony", "blackberry", "nokia", "samsung", "samsung", "samsung", "huawei", "lg", "lg", "huawei", "lg", "asus", "lg", "lg", "lg", "asus", "zte", "caterpillar", "caterpillar", "htc", "htc", "siemens", "siemens", "huawei", "huawei", "huawei", "huawei")


dis_brand_title <- sapply(model, function(x) {
  y <- levenshteinSim(title_token$word, x)
  y
})

dis_brand_all <- sapply(model, function(x) {
  y <- levenshteinSim(all_token$word, x)
  y
})

dis_brand_title <- data.frame(dis_brand_title)
dis_brand_all <- data.frame(dis_brand_all)

brand_prob_title <- cbind(title_token, dis_brand_title)
brand_prob_all <- cbind(all_token, dis_brand_all)


brand_by_title <- gather(brand_prob_title, "model", "prob", 3:dim(brand_prob_title)[2]) %>% arrange(id, word) %>% filter(prob > title_prob_precision) %>% group_by(id) %>% top_n(n = 1) %>% slice(1)


index_of_titles <- brand_by_title %>%
  select(id)

not_specified_brand <- brand_prob_all %>% 
  filter(!(id %in% index_of_titles$id))

brand_by_all_token <- gather(not_specified_brand, "model", "prob", 3:dim(brand_prob_all)[2]) %>% arrange(id, word) %>% filter(prob > all_token_prob_precision) %>% group_by(id) %>% top_n(n = 1) %>% slice(1)


brand_result <- rbind(brand_by_title, brand_by_all_token) %>% arrange(id)

brand_result$brand <- mapvalues(brand_result$model, from = model, to = brand)

write.table(brand_result$brand, "Results/brand.txt", row.names=F, sep="\n", quote = F)

ids <- 1:1000
unknown_ids <- ids[!(ids %in% brand_result$id)]



