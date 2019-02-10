# in the name of god
library(dplyr)
library(tidytext)
library(RecordLinkage)
library(stringdist)
library(tidyr)
library(plyr)
library(stringr)

rm(list=ls())

setwd("~/Documents/datadays/")
td <- read.csv("Data/divar_posts_dataset.csv", stringsAsFactors = F)
td <- td %>% filter(city == "Karaj" | city == "Tabriz" | city == "Shiraz" | city == "Ahvaz")
only_cars <- td %>% filter(cat2 == "cars")

all_counts <- count(td, 'city')
cars_counts <- count(only_cars, 'city')

result <- merge(x = all_counts, y = cars_counts, by="city") %>% mutate(result = freq.y / freq.x)

