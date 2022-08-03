library(tidyverse)
library(readxl)
library(janitor)
library(ggrepel)

# https://www.nature.com/articles/s41597-022-01364-9
brain <- read_delim("data/animaltraits_db.csv") %>% 
            clean_names() %>% 
            filter(class == "Mammalia") %>% 
            select(-species) %>% 
            rename(species = specific_epithet) %>% 
            select(genus, species, body_mass, metabolic_rate, mass_specific_metabolic_rate,
                   brain_size)

# # paper: Breakdown of brain–body allometry and the encephalization of birds and mammals
# brain <- read_xlsx("data/Tsuboi_etal_NEE_mammal.xlsx") %>% 
#             clean_names()

# genome <- read_xls("data/genome_size.xls") %>% 
#             clean_names() %>% 
#             mutate(c_value = as.numeric(c_value))

lh <- read_delim("data/AnAge.txt") %>% 
        clean_names()

df <- brain %>% 
       
        inner_join(lh) 
        
    
        inner_join(lh, by = c( "order", "family", "genus", "species")) %>% 
        filter(order == "Primates") %>% 
        group_by(species) %>% 
        summarise(mean_brain_vol = mean(brain_mass_g),
                  mean_longevity = mean(maximum_longevity_yrs))

ggplot(df, aes(mean_brain_vol, mean_longevity, color = order)) +
    geom_smooth(method = "lm", se=FALSE) +
    geom_point() +
    #scale_x_log10() +
    scale_y_log10()

ggplot(bg, aes(brain_size, c_value, col = order, label = common_name)) +
    geom_point() +
    #geom_text_repel() +
    theme(legend.position = "none") 
