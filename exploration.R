library(tidyverse)
library(readxl)
library(janitor)
library(ggrepel)
brain <- read_xlsx("data/observations.xlsx") %>% 
            clean_names() %>% 
            filter(class == "Mammalia") %>% 
            #filter(order == "Primates") %>% 
            select(1:7, contains(c("brain", "body")))

genome <- read_xls("data/genome_size_data_050622_00_41_07.xls") %>% 
            clean_names() %>% 
            mutate(c_value = as.numeric(c_value))

bg <- brain %>% 
        left_join(genome) %>% 
        filter(order == "Primates")


ggplot(bg, aes(brain_size, c_value, col = order, label = common_name)) +
    geom_point() +
    geom_text_repel()
