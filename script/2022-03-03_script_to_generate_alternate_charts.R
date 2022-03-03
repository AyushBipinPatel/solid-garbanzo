### This is the script I shall use to create alternative visualizations
### for the chart shown in the readme file as the current chart.

### My sense is that the idea to present MPI headcount and $1.90 a day headcount 
### is to point out that these two measure capture and show different pictures of poverty.
### Given this I believe this can be shown relatively better by a dumbbell chart or a chart 
### with 45 degree line and mpi poverty on one axis and $1.90 poverty on another axis.


# libraries ---------------------------------------------------------------

library(here)
library(tidyverse)


# read in data ------------------------------------------------------------

data_headcount <- read_csv(here("data/data_to_generate_chart_taskcard2.csv"))

## get the column names in order

data_headcount %>% 
  janitor::clean_names() -> data_headcount


# prepare the 45degree comparison chart ----------------------------------

data_headcount %>% 
  mutate(
    survey = fct_lump_min(as.factor(survey),min = 4)
  ) %>% 
  ggplot(aes(h_headcount_ratio_of_poverty_percent,x1_90_day))+
  geom_point(alpha = 0.5, size = 6,
             aes(colour = survey)) + # setting alpha as there might be many overlapps
  geom_function(fun = function(x) x,linetype = 2, 
                colour = "steelblue", alpha = 0.8)+
  labs(
    x = "Multidimensional Poverty Level (H)",
    y = "$1.90 a day Poverty Level",
    title = "Multidimensional Poverty and $1.90/day at country level",
    subtitle = "For most countries, $1.90 a day underestimates Poverty Levels Compared to MPI"
  )+
  theme_bw()+
  theme(
    axis.title = element_text(size = 12,face = "bold"),
    axis.text = element_text(size = 10,face = "bold"),
    plot.title = element_text(size = 16, face ="bold" ),
    plot.subtitle = element_text(size = 12, face ="bold" ),
  ) -> option_1


ggsave(filename = here("images/2022-03-03-option1.png"),
       plot = option_1,
       units = "in",
       width = 16,
       height = 12,
       device = "png")
