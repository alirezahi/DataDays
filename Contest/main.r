# in the name of god
library(dplyr)
library(tidytext)
library(devtools)
library(RecordLinkage)
library(tidyr)
library(stringr)

rm(list=ls())

setwd("~/Documents/datadays/")
td <- read.csv("Data/cafe_baazaar_dataset.csv", stringsAsFactors = F)

desc_text <- td %>% select(X,desc)

token_distribution <- desc_text %>%
  unnest_tokens(word, desc) %>%
  group_by(word) %>%
  summarise(count = n()) %>%
  arrange(desc(count))


keywords <- c("سالم","نو","قیمت","رنگ","تمیز","فقط","بیمه","تخفیف")
#keywords <- c("تخفیف")
td$keywords <- sapply(1:nrow(td), function(id) {
  desc <- td[id,]$desc
  desc_split <- strsplit(desc, ' ')[[1]]
  sum(desc_split %in% keywords)
})

td$archive_by_user <- as.boolean(td$archive_by_user)

td_archive_true <- filter(td, archive_by_user == T)
td_archive_false <- filter(td, archive_by_user == F)

sd(td_archive_true$keywords)
sd(td_archive_false$keywords)

wilcox.test(td_archive_true$keywords, td_archive_false$keywords)



