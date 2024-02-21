library(ggplot2)
library(shiny)
library(plotly)
library(dplyr)
library(reshape2)
library(tidyr)

#create data object
my_data = read.csv("RS_Session_259_AU_2438_3.csv")

#structure of the data
my_data %>%
  str()

#Summary of the data
my_data %>%
  summary()

#first few rows of the data
my_data %>%
  head()



