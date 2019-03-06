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
td <- td %>% mutate(hour = unlist(strsplit(created_at, " "))[rep(c(F,T), nrow(td))])
td <- td %>% mutate(day = unlist(strsplit(created_at, " "))[rep(c(T,F), nrow(td))])


### single

## time

hour_dist <- data.frame(table(td$hour))
hour_dist$Var1 <- factor(hour_dist$Var1, levels = c("12AM", "01AM", "02AM", "03AM", "04AM", "05AM", "06AM", "07AM","08AM","09AM","10AM","11AM","12PM","01PM", "02PM", "03PM", "04PM", "05PM", "06PM", "07PM","08PM","09PM","10PM","11PM"))
ggplot(hour_dist, aes(Var1, Freq)) + geom_bar(stat = "identity")

## archive percentage for each city

td_archived <- filter(td, archive_by_user == T)

td_city_archived <- td_archived %>%
  group_by(city) %>% summarise(count = n())

td_city <- td %>%
  group_by(city) %>% summarise(count = n())

td_city$count_archive <- td_city_archived$count
td_city$per <- td_city$count_archive / td_city$count

ggplot(td_city, aes(city, per, fill = city)) + geom_bar(stat="identity")



### double

## task 1

plot_dis_day_cat <- function(cat_name) {
  td_specific_cat <- td %>% filter(cat1 == cat_name) %>% group_by(day) %>% summarise(count = n())
  ggplot(td_specific_cat, aes(day, count, fill = day)) + geom_bar(stat = "identity") + ggtitle(cat_name)
}
plot_dis_day_cat("leisure-hobbies")

unique(td$cat1)


## task 2

plot_dis_cat_city <- function(city_name) {
  td_specific_city <- td %>% filter(city == city_name) %>% group_by(cat1) %>% summarise(count = n())
  ggplot(td_specific_city, aes(cat1, count, fill = cat1)) + geom_bar(stat = "identity") + ggtitle(city_name)
}

plot_dis_cat_city("Tehran")
plot_dis_cat_city("Mashhad")
plot_dis_cat_city("Karaj")
plot_dis_cat_city("Qom")
plot_dis_cat_city("Isfahan")
plot_dis_cat_city("Shiraz")
plot_dis_cat_city("Tabriz")
plot_dis_cat_city("Ahvaz")
plot_dis_cat_city("Kermanshah")


unique(td$city)


