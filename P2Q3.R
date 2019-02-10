# in the name of god

setwd("~/Documents/datadays/")
tb <- read.csv(file = "Data/divar_posts_dataset.csv", stringsAsFactors = F)


cars <- tb %>% filter(cat2 == "cars")
cars <- cars[grepl(".* 06PM", tb_cars$created_at),] %>% filter(year==1394)
cars <- na.omit(cars)

mashhad_cars <- cars %>% filter(city == "Mashhad")
karaj_cars <- cars %>% filter(city == "Karaj")
shiraz_cars <- cars %>% filter(city == "Shiraz")
isf_cars <- cars %>% filter(city == "Isfahan")
ker_cars <- cars %>% filter(city == "Kermanshah")
ahvaz_cars <- cars %>% filter(city == "Ahvaz")


target1_cars <- rbind(mashhad_cars, karaj_cars, shiraz_cars)
target2_cars <- rbind(isf_cars, karaj_cars, ker_cars)
target3_cars <- rbind(isf_cars, ahvaz_cars, ker_cars)


anova(aov(mileage ~ city, target1_cars))
anova(aov(mileage ~ city, target2_cars))
anova(aov(mileage ~ city, target3_cars))
