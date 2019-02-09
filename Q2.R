# in the name of god
library(dplyr)
library(tidytext)
library(RecordLinkage)
library(tidyr)
library(plyr)
library(stringr)

rm(list=ls())

setwd("~/Documents/datadays/")
td <- read.csv("Data/divar_posts_dataset.csv", stringsAsFactors = F, nrows = 1000)

pc <- td %>% filter(cat1 == "electronic-devices" & cat2 == "computers" & cat3 == "desktops")
saz <- td %>% filter(cat1 == "leisure-hobbies" & cat2 == "musical-instruments" & cat3 == "traditional")
farsh <- td %>% filter(cat1 == "for-the-home" & cat2 == "furniture-and-home-decore" & cat3 == "carpets")
kafsh <- td %>% filter(cat1 == "personal" & cat2 == "clothing-and-shoes" & cat3 == "shoes-belt-bag")

pc_pm <- pc[grepl("Wednesday [0-9]*PM", pc$created_at),]
saz_pm <- saz[grepl("Wednesday [0-9]*PM", saz$created_at),]
farsh_pm <- farsh[grepl("Wednesday [0-9]*PM", farsh$created_at),]
kafsh_pm <- kafsh[grepl("Wednesday [0-9]*PM", kafsh$created_at),]

nrow(pc_pm)
nrow(saz_pm)
nrow(farsh_pm)
nrow(kafsh_pm)