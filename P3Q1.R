# in the name of god
library(dplyr)
library(tidytext)
library(RecordLinkage)
library(tidyr)
library(plyr)
library(stringr)

rm(list=ls())

setwd("~/Documents/datadays/")
td <- read.csv("Data/divar_posts_dataset.csv", stringsAsFactors = F)
only_cars <- td %>% filter(cat2 == "cars")
only_cars_mvm <- only_cars[grepl("MVM*", only_cars$brand),]
only_cars_mvm_price <- only_cars_mvm %>% filter( price <= 0)

nrow(only_cars_mvm_price)