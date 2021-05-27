# install.packages("tidyverse")
# install.packages("data.table")
# install.packages("dplyr")
# install.packages("ggthemes")
# install.packages("knitr")
# install.packages("rmarkdown")
# install.packages('tinytex')
# tinytex::install_tinytex() 

library(data.table)
library(ggplot2)
library(dplyr)
library(ggthemes)
library(tidyr)
# Set Up
setwd("~/Documents/HTW/Quantitative/M6.1-Quantitative-Approaches-to-Management/01")
theme_set(theme_bw())

# Import and cleaning NA rows
property_prices <- fread("./property_prices.csv")
property_prices <- property_prices[complete.cases(property_prices), ]
names(property_prices) <- gsub(" ", "_", tolower(names(property_prices)))

# Fix living area data
property_prices <- property_prices %>%
  mutate(living_area_sq_ft = ifelse(living_area_sq_ft > 10, living_area_sq_ft/1000, living_area_sq_ft))

property_prices$living_area_sq_ft
str(property_prices)
tail(property_prices)


ggplot(property_prices, aes(x = selling_price)) + 
  geom_line(aes(y = living_area_sq_ft)) +
  geom_line(aes(y = area_in_sq_ft)) +
  labs(x = "Selling price", y = "Area square feet")


# Local Price vs Selling Price
ggplot(property_prices, aes(x = selling_price)) + 
  geom_line(aes(y = living_area_sq_ft, color =" green")) +
  geom_line(aes(y = area_in_sq_ft, color = "darkblue")) +
  labs(x = "Selling price", y = "") +  
  scale_color_discrete(name = "Area (square feet)", labels = c("Living", "Property"))

facilities <- property_prices$bathrooms + property_prices$bedrooms + property_prices$garages

ggplot(property_prices, aes(x = rooms, color = facilities)) +
  geom_point(aes(y = facilities)) + 
  scale_color_gradient(low = "blue", high = "red")

property_prices %>%
  group_by(rooms) %>%
  summarise_each(funs(max, min, mean, median, sd), value)


property_by_room <- property_prices %>%
  group_by(rooms)

property_by_room_facilities <- property_by_room %>%
  summarise(median_bathroom = median(bathrooms),
    median_garage = median(garages),
    median_bedroom = median(bedrooms),
    median_fireplace = median(fireplace),
    total = sum(median_garage, median_bedroom, median_fireplace))
property_by_room_facilities

pivot_features <- pivot_longer(property_by_room_facilities, cols=c('median_bathroom', 'median_garage','median_bedroom', 'median_fireplace'), names_to='feat_category', values_to="value")
ggplot(pivot_features, aes(x = rooms, y = value, fill = feat_category)) +
  geom_bar(stat = 'identity', position='stack') +
  labs(x = "Number of rooms", y = "Features")

property_by_room_summary <- property_by_room %>%
  summarise(
    mean_selling_price = mean(selling_price),
    mean_local_price = mean(local_price),
    mean_living_area = mean(living_area_sq_ft),
    mean_area_in_sq_ft = mean(area_in_sq_ft),
    count = n())



ggplot(pivot, aes(x = rooms, ))
property_by_room_summary

