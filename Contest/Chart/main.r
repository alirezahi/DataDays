# in the name of god
library(dplyr)
library(ggplot2)
library(tidytext)
library(RecordLinkage)
library(tidyr)
library(stringr)

rm(list=ls())

setwd("~/Documents/datadays/")
td <- read.csv("Data/cafe_baazaar_dataset.csv", stringsAsFactors = F, nrow=3000)
td$archive_by_user <- as.boolean(td$archive_by_user)

# td_filtered <- filter(td, cat1 == "personal")

# td_filtered <- filter(td, archive_by_user == TRUE)

new_td <- td %>% mutate(hour = str_extract(created_at, ","))

which.max(x) %>% as.matrix() %>% rownames()

td_city <- filter(td)

result_city <- td %>%
  group_by(city) %>%
  
result_city <- summerise(mode= which.max(table()))
result_city_count <- td %>%
  group_by(city) %>%
  summarise(count = n())

result <- td_filtered %>%
  group_by(city) %>%
  summarise(count = n())

result$per <- result$count / result_city$count

ggplot(result, aes(city, per)) + geom_bar(stat="identity")
