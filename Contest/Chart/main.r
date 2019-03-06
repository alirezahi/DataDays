# in the name of god
library(dplyr)
library(ggplot2)
library(tidytext)
library(RecordLinkage)
library(tidyr)
library(stringr)

rm(list=ls())

setwd("~/Documents/datadays/")
td <- read.csv("Data/cafe_baazaar_dataset.csv", stringsAsFactors = F)
td$archive_by_user <- as.boolean(td$archive_by_user)

# td_filtered <- filter(td, cat1 == "personal")

# td_filtered <- filter(td, archive_by_user == TRUE)

## map question 

new_td <- td %>%  mutate(hour = unlist(strsplit(created_at, " "))[rep(c(F,T), nrow(td))])

new_td <- new_td %>%
  group_by(city, hour) %>%
  summarise(count = n()) %>%
  arrange(city, desc(count)) %>%
  top_n(1)

new_td$count <- as.factor(new_td$count)

ggplot(new_td, aes(city, hour, color = count)) + geom_point()

## end map question



# outlier


new_td <- td %>%
  filter(cat1 == 'vehicles' & price != -1)


ggplot(new_td, aes(x=cat1, y=price)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=4)

# end outlier


td_city <- filter(td)

result_city <- td %>%
  group_by(city)
  
result_city <- summarise(mode= which.max(table()))
result_city_count <- td %>%
  group_by(city) %>%
  summarise(count = n())

result <- td %>%
  group_by(city) %>%
  summarise(count = n())

result$per <- result$count / result_city$count

ggplot(result, aes(city, per)) + geom_bar(stat="identity")
