# in the name of god
library(dplyr)
library(tidytext)
library(RecordLinkage)
library(stringdist)
library(tidyr)
library(plyr)
library(stringr)

rm(list=ls())

title_prob_precision <- 0.8
all_token_prob_precision <- 0.5

setwd("~/Documents/datadays/")
td = read.csv("Data/dataset.csv", stringsAsFactors = F)
td$id = 1:nrow(td)
td$desc = chartr(old = "۱۲۳۴۵۶۷۸۹۰١٢٣٤٥٦٧٨٩٠", new = "12345678901234567890",td$desc)
td$title = chartr(old = "۱۲۳۴۵۶۷۸۹۰١٢٣٤٥٦٧٨٩٠", new = "12345678901234567890",td$title)



desc_token <- td %>% select(id, desc) %>% unnest_tokens(word, desc)
title_token <- td %>% select(id, title) %>% unnest_tokens(word, title)
all_token <- rbind(title_token, desc_token) %>% arrange(id)


model <- c("iphone", "samsung", "huawei", "nokia" ,"lenovo", "sony", "lg", "htc" , "galaxy", "motorola", "apple", "نوکیا", "آیفون", "سامسونگ", "هواوی","ال جی", "سونی", "لنوو","اچ تی سی", "گلکسی", "موتورولا", "اپل", "note2","note3","note4","note5","note6","note7","note8","نوت2","نوت7","نوت6","نوت5","نوت4","نوت3","نوت9","نوت8","j1","j2","j3","j4","j5","j6","j7","جی1","جی2","جی3","جی4","جی5","جی6","جی7","s3","s4","s5","s6","s7","s8","s9","اس3","اس4","اس5","اس6","اس7","اس8","اس9","z1","z10","lumia","a5","a6","a7","honor","nexus5", "nexus5x", "nexus6p", "nexus4", "nexus7", "نکسوس5","نکسوس5 ایکس","نکسوس4","نکسوس7", "zte","desire","دیزایر","هانر","g610","g620","g630","blackberry","amazon","sony ericsson","farassoo","dell","acer","asus","لومیا","فراسو","ایسوس","ایسوز","ایسر","اریکسون","بلکبری","موتورلا","آمازون","زدتیای","xperia","اکسپریا","k510","ایفون","p9","p8","a8","passport","grand","گرند","a3","چاچا","chacha","مگا","mega","8800","g700","پی8","پی7","پی9","یانگ","young","plus","پلاس","1100")
brand <- c("Apple::اپل", "Samsung::سامسونگ", "Huawei::هوآوی", "Nokia::نوکیا", "Lenovo::لنوو", "Sony::سونی", "LG::ال‌جی", "HTC::اچ‌تی‌سی", "Samsung::سامسونگ", "Motorola::موتورلا", "Apple::اپل", "Nokia::نوکیا", "Apple::اپل", "Samsung::سامسونگ", "Huawei::هوآوی", "LG::ال‌جی", "Sony::سونی", "Lenovo::لنوو", "HTC::اچ‌تی‌سی", "Samsung::سامسونگ", "Motorola::موتورلا","Apple::اپل", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Sony::سونی", "BlackBerry::بلک‌بری", "Nokia::نوکیا", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ", "Huawei::هوآوی", "LG::ال‌جی", "LG::ال‌جی", "Huawei::هوآوی", "LG::ال‌جی", "Asus::ایسوس", "LG::ال‌جی", "LG::ال‌جی", "LG::ال‌جی", "Asus::ایسوس", "ZTE::زدتی‌ای", "HTC::اچ‌تی‌سی", "HTC::اچ‌تی‌سی", "Huawei::هوآوی", "Huawei::هوآوی", "Huawei::هوآوی", "Huawei::هوآوی","BlackBerry::بلک‌بری","Amazon::آمازون", "Sony Ericsson::سونی اریکسون","Farassoo::فراسو","Dell::دل","Acer::ایسر","Asus::ایسوس","Nokia::نوکیا","Farassoo::فراسو","Asus::ایسوس","Asus::ایسوس","Acer::ایسر","Sony Ericsson::سونی اریکسون","BlackBerry::بلک‌بری","Motorola::موتورلا","Amazon::آمازون","ZTE::زدتی‌ای","Sony Ericsson::سونی اریکسون","Sony Ericsson::سونی اریکسون","Sony Ericsson::سونی اریکسون","Apple::اپل", "Huawei::هوآوی", "Huawei::هوآوی", "Samsung::سامسونگ","BlackBerry::بلک‌بری", "Samsung::سامسونگ", "Samsung::سامسونگ", "Samsung::سامسونگ","HTC::اچ‌تی‌سی","HTC::اچ‌تی‌سی","Samsung::سامسونگ","Samsung::سامسونگ","Nokia::نوکیا","Huawei::هوآوی","Huawei::هوآوی","Huawei::هوآوی","Huawei::هوآوی","Samsung::سامسونگ","Samsung::سامسونگ","Apple::اپل","Apple::اپل","Nokia::نوکیا")


model_replace <- c(model,c('اچ.تی.سی','ال.جی'))
brand_replace <- c(brand,c('HTC::اچ‌تی‌سی','LG::ال‌جی'))

model_substr <- c(model_replace,c("بلک بری","ال جی"))
brand_substr <- c(brand_replace,c("BlackBerry::بلکبری","LG::الجی"))

convert_arr_model <- c(model_substr,c("X1100","X8800","ال.جی.1","سونی","اچ.تی.سی.1"))
convert_arr_brand <- c(brand_substr,c("Nokia::نوکیا","Nokia::نوکیا","LG::ال‌جی","Sony::سونی","HTC::اچ‌تی‌سی"))

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


index_of_titles <- brand_by_title %>% select(id)

not_specified_brand <- brand_prob_all %>% filter(!(id %in% index_of_titles$id))
brand_by_all_token <- gather(not_specified_brand, "model", "prob", 3:dim(brand_prob_all)[2]) %>% arrange(id, word) %>% filter(prob > all_token_prob_precision) %>% group_by(id) %>% top_n(n = 1) %>% slice(1)
brand_result <- rbind(brand_by_title, brand_by_all_token) %>% arrange(id)
brand_result$brand <- mapvalues(brand_result$model, from = convert_arr_model, to = convert_arr_brand)



##### find brand from substring

ids <- 1:1000
unknown_ids <- ids[!(ids %in% brand_result$id)]

title_substr <- td %>% filter(id %in% unknown_ids)

substr_brand <- sapply(model_substr, function(x) {
  y <- grepl(x, title_substr$title, ignore.case = TRUE)
  y
})

substr_brand <- data.frame(substr_brand)
brand_prob_title_substr <- cbind(title_substr, substr_brand)
brand_prob_title_substr <- gather(brand_prob_title_substr, "mobile_type", "is_substr", 15:dim(brand_prob_title_substr)[2]) %>% arrange(id) %>% filter(is_substr == TRUE) %>% group_by(id) %>% top_n(n = 1) %>% slice(1) %>% select(id, mobile_type)

unknown_ids <- ids[!(ids %in% c(brand_result$id,brand_prob_title_substr$id))]

desc_substr <- td %>% filter(id %in% unknown_ids)

substr_brand <- sapply(model_substr, function(x) {
  y <- grepl(x, desc_substr$desc)
  y
})

substr_brand <- data.frame(substr_brand)
brand_prob_desc_substr <- cbind(desc_substr, substr_brand)
brand_prob_desc_substr <- gather(brand_prob_desc_substr, "mobile_type", "is_substr", 15:dim(brand_prob_desc_substr)[2]) %>% arrange(id) %>% filter(is_substr == TRUE) %>% group_by(id) %>% top_n(n = 1) %>% slice(1) %>% select(id, mobile_type)

substr_result <- rbind(brand_prob_title_substr, brand_prob_desc_substr)
substr_result$brand <- mapvalues(substr_result$mobile_type, from = convert_arr_model, to = convert_arr_brand)


#### find brand using agrep

unknown_ids <- ids[!(ids %in% c(brand_result$id,substr_result$id))]

others_token <- all_token %>% filter(id %in% unknown_ids)
dis_brand_others <- sapply(model, function(x) {
  y <- agrepl(x, others_token$word, max.distance = 0.5, ignore.case = T)
  z <- levenshteinSim(others_token$word, x)
  y * z
})


dis_brand_others <- data.frame(dis_brand_others)
brand_prob_others <- cbind(others_token, dis_brand_others)
brand_by_others <- gather(brand_prob_others, "model", "prob", 3:dim(brand_prob_others)[2]) %>% arrange(id, word) %>% group_by(id) %>% top_n(n = 1) %>% slice(1)
brand_by_others$brand <- mapvalues(brand_by_others$model, from = convert_arr_model, to = convert_arr_brand)


### gather the results

result <- rbind(brand_by_others, brand_result) %>% select(id, brand) %>% rbind(select(substr_result, id, brand)) %>% arrange(id)
write.table(result$brand, "Results/brand.txt", row.names=F, sep="\n", quote = F, col.names = F)

