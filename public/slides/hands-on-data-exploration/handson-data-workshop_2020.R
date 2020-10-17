


## ----pckgs-needed-----------------------------
pckgs <- c("nycflights13", "mosaic",  "broom", "corrr", "lubridate", "viridis", 
           "GGally", "ggmap", "pacman", "sjmisc", "leaflet", "knitr",  "tidyverse", 
           "tidyimpute", "na.tools", "checkpoint", "hrbrthemes")





## ----name-pckgs, echo = FALSE-----------------
library(nycflights13)
library(mosaic)
library(broom)
library(corrr)
library(lubridate)
library(viridis)
library(GGally)
library(ggmap)
library(sjmisc)
library(leaflet)
library(knitr)
library(tidyverse)
library(tidyimpute)
library(na.tools)
library(fontawesome)
library(icon)
library("hrbrthemes")


## ----install-nycflights, eval = FALSE---------
## install.packages("nycflights13")


## ----load-pckgs-------------------------------

# install.packages("pacman")
library(pacman)
p_load(pckgs, character.only = TRUE)


## ---------------------------------------------
data(mtcars)


## ---------------------------------------------
?mtcars


## ----load-flights-----------------------------
data(flights, package = "nycflights13")


## ---------------------------------------------
?flights



## ---------------------------------------------
glimpse(mtcars)


## ----echo = TRUE------------------------------
filter(mtcars, cyl == 6)


## ----eval  = FALSE----------------------------
data(mtcars)  # only if dataset is not yet loaded
filter(mtcars, am == 1)
filter(mtcars, cyl > 4)
filter(mtcars, mpg > 30 | mpg < 12)




## ----echo = TRUE, eval = FALSE----------------
select(mtcars, cyl, hp)


## ----echo = FALSE-----------------------------
select(mtcars, cyl, hp) %>% 
  head()


## ----eval  = FALSE----------------------------
select(mtcars, 1:3)
select(mtcars, 1, disp)
select(mtcars, contains("c"))  # regex supported




## ----echo = TRUE------------------------------
mtcars <- mutate(mtcars, 
                 weight_kg = wt * 2)
head(select(mtcars, wt, weight_kg))


## ----eval  = TRUE-----------------------------
mtcars <- mutate(mtcars, consumption = (1/mpg) * 100 * 3.8 / 1.6)
mtcars <- mutate(mtcars, 
                 consumption_g_per_m = (1/mpg),
                 consumption_l_per_100_k = consumption_g_per_m  * 3.8 / 1.6 * 100)




## ----echo = TRUE------------------------------
summarise(mtcars, 
          mean_hp = mean(hp))


## ----eval  = TRUE-----------------------------
summarise(mtcars, median(consumption))
summarise(mtcars, 
          consumption_md = median(consumption),
          consumption_avg = mean(consumption)
          )




## ----echo = TRUE------------------------------
mtcars_grouped <- group_by(mtcars, am)
summarise(mtcars_grouped, mean_hp = mean(hp))


## ----echo  = TRUE-----------------------------
mtcars_grouped <- group_by(mtcars, cyl)
summarise(mtcars_grouped, mean_hp = mean(consumption))

mtcars_grouped <- group_by(mtcars, cyl,am)
mtcars_summarized <- summarise(mtcars_grouped, 
                               mean_hp = mean(consumption),
                               sd_hp = sd(consumption))  



## ----eval = FALSE-----------------------------
## summarise(
##   raise_to_power(
##     compute_differences(data, mean),
##     2
##   ),
##   mean
## )
 


## ----eval = FALSE-----------------------------
 data %>%
   compute_differences(mean) %>%
   raise_to_power(2) %>%
   summarise(mean)
 


## ----echo = TRUE------------------------------
data <- mtcars$hp

data %>% 
  `-`(mean(data)) %>% 
  `^`(2) %>% 
  mean()


var(mtcars$hp) * (length(data)-1) / length(data)



## ----out.width="50%"--------------------------
mtcars %>% 
  ggplot() +  # initialize plot
  aes(x = hp, y = mpg) +  # define axes etc.
  geom_point() +  # graw points 
  geom_smooth()  # draw smoothing line


## ----dpi=300----------------------------------
mtcars %>% 
  ggplot(aes(x = hp, y = mpg, color = am)) +
  geom_point() +
  geom_smooth() +
  scale_color_viridis_c() +  # package "viridis" needed
  theme_bw() 


## ---------------------------------------------
mtcars_summarized %>% 
  ggplot() +
  aes(x = cyl, y = mean_hp, color = factor(am), 
      shape = factor(am)) +
  geom_point(size = 5)


## ----out.width = "50%"------------------------
mtcars_summarized %>% 
  ggplot(aes(x = cyl, color = factor(am), shape = factor(am))) +
  geom_errorbar(aes(ymin = mean_hp - sd_hp, ymax = mean_hp + sd_hp), width = .2, 
                position =  position_dodge(width=0.9)) + 
  geom_point(aes(y = mean_hp), size = 5, position =  position_dodge(width=0.9)) 
  


## ---------------------------------------------
data(flights)


## ----eval = FALSE-----------------------------
?flights


## ---------------------------------------------
glimpse(flights)


## ----out.width = "120%", eval = TRUE----------
flights %>% descr() 


## ----eval = TRUE------------------------------
flights %>%
  select_if(is.character) %>% 
  inspect()


## ---------------------------------------------
flights %>% 
  ggplot(aes(x = dep_delay)) +
  geom_histogram() +
  scale_x_continuous(limits = c(-10, 60))


## ---------------------------------------------
flights_nona <- flights %>% 
  drop_na()

nrow(flights_nona) / nrow(flights)


## ---------------------------------------------
flights_nona2 <- flights %>% 
  mutate(dep_delay = ifelse(is.na(dep_delay),
                            mean(dep_delay, na.rm = TRUE), dep_delay))

flights_nona2 %>% 
  summarise(sum(is.na(dep_delay)))


## ----results = "hide"-------------------------
flights_nona3 <- flights %>% 
  impute_all(na.mean)

flights_nona3 %>% 
  purrr::map(~sum(is.na(.)))


## ---------------------------------------------
flights %>% 
  mutate(NA_row = rowSums(is.na(.))) %>% 
  ggplot(aes(x = NA_row)) + geom_histogram()


## ---------------------------------------------
flights %>% 
  drop_na() %>% 
  summarise(mean(dep_delay), median(dep_delay),
            sd(dep_delay), iqr(dep_delay))


## ---------------------------------------------
flights %>% 
  drop_na() %>% 
  group_by(origin) %>% 
  summarise(mean(dep_delay), median(dep_delay),
            sd(dep_delay), iqr(dep_delay))


## ---------------------------------------------
lm(dep_delay ~ origin, data = drop_na(flights)) %>% tidy()


## ----eval = FALSE-----------------------------
## flights %>%
   ggplot(aes (x = distance, y = dep_delay)) +
   geom_point(alpha = .1) +
   geom_lm() +
   coord_cartesian(ylim(-10, 60))


## ----echo = FALSE-----------------------------

# computationally heavy! (90 seconds on my machine)
flights %>% 
  ggplot(aes (x = distance, y = dep_delay)) +
  geom_point(alpha = .1) +
  geom_smooth() +
  coord_cartesian(ylim = c(-10, 60)) 


## ----eval = FALSE-----------------------------
## flights %>%
##   mutate(distance_bins = case_when(
##     distance < 250 ~ 250,
##     distance < 500 ~ 500,
##     distance < 1000 ~ 1000,
##     distance < 2000 ~ 2000,
##     distance < 3000 ~ 3000,
##     TRUE ~ 5000 )) %>%
##   ggplot(aes (y = dep_delay)) +
##   geom_boxplot(aes(x = distance_bins,
##   group = distance_bins)) +
##   geom_smooth(aes(x = distance)) +
##   coord_cartesian(ylim = c(-10, 60))


## ----echo = FALSE-----------------------------

# computationally heavy! (30 secs)
flights %>% 
  mutate(distance_bins = case_when(
    distance < 250 ~ 250,
    distance < 500 ~ 500,
    distance < 1000 ~ 1000,
    distance < 2000 ~ 2000,
    distance < 3000 ~ 3000,
    TRUE ~ 5000
  )) %>% 
  ggplot(aes (y = dep_delay)) +
  geom_boxplot(aes(x = distance_bins, 
  group = distance_bins)) +
  geom_smooth(aes(x = distance)) +
  coord_cartesian(ylim = c(-10, 60)) 


## ---------------------------------------------
flights %>% 
  select(distance, dep_delay, origin) %>%
  group_by(origin) %>% 
  drop_na() %>% 
  summarise(cor_delay_dist = cor(dep_delay, distance))


## ---------------------------------------------
lm(dep_delay ~ I(distance/1000) + origin, 
   data = flights) %>% 
  tidy()


## ----eval = FALSE-----------------------------
## p1 <- flights %>%
##   group_by(origin, month, day) %>%
##   summarise(dep_delay_avg_day = mean(dep_delay, na.rm = TRUE)) %>%
##   ungroup %>%
##   mutate(dep_dt = make_date(2013, month, day)) %>%
##   ggplot(aes(x = dep_dt, y = dep_delay_avg_day, shape = origin, color = origin)) +
##   geom_point(alpha = .3) +
##   geom_smooth() +
##   scale_color_viridis_d()
## p1


## ----echo = FALSE, out.width= "100%"----------
p1 <- flights %>% 
  group_by(origin, month, day) %>% 
  summarise(dep_delay_avg_day = mean(dep_delay, na.rm = TRUE)) %>% 
  ungroup %>% 
  mutate(dep_dt = make_date(2013, month, day)) %>% 
  ggplot(aes(x = dep_dt, y = dep_delay_avg_day, shape = origin, color = origin)) +
  geom_point(alpha = .3) +
  geom_smooth() +
  scale_color_viridis_d()
p1


## ----eval = FALSE-----------------------------
## flights %>%
##   ggplot(aes(x = month, y = dep_delay)) +
##   geom_boxplot(aes(group = month)) +
##   geom_smooth() +
##   coord_cartesian(ylim = c(-10, 60)) +
##   scale_x_continuous(breaks = 1:12)


## ----echo = FALSE-----------------------------
flights %>% 
  ggplot(aes(x = month, y = dep_delay)) +
  geom_boxplot(aes(group = month)) +
  geom_smooth() +
  coord_cartesian(ylim = c(-10, 60)) +
  scale_x_continuous(breaks = 1:12)


## ---------------------------------------------
flights <- flights %>%
  mutate(dow = wday(time_hour),
         weekend = case_when(
           dow %in% c(6, 7) ~ TRUE,
           TRUE ~ FALSE))

delay_dow <- 
  flights %>% 
  group_by(dow) %>% 
  drop_na() %>% 
  summarise(delay_m = mean(dep_delay),
            delay_md = median(dep_delay),
            q_05 = quantile(x = dep_delay, prob = .05),
            q_95 = quantile(x = dep_delay, prob = .95))


## ---------------------------------------------
delay_dow %>% kable(format='html')


## ----eval = FALSE-----------------------------
## flights %>%
##   ggplot(aes(x = dow)) +
##   geom_boxplot(aes(group = dow, y = dep_delay, color = weekend)) +
##   geom_point(data = delay_dow, aes(y = delay_m), color = "red",
##              size = 5) +
##   coord_cartesian(ylim = c(-10, 100)) +
##   scale_x_continuous(breaks = 1:7) +
##   geom_hline(yintercept = mean(flights$dep_delay, na.rm = TRUE),
##              linetype = "dashed") +
##   geom_hline(yintercept = median(flights$dep_delay, na.rm = TRUE),
##              linetype = "dashed") +
##   geom_errorbar(aes(ymin = q_05, ymax = q_95), data = delay_dow)


## ----echo = FALSE, fig.asp = .6---------------
flights %>% 
  ggplot(aes(x = dow)) +
  geom_boxplot(aes(group = dow, y = dep_delay, color = weekend)) +
  geom_point(data = delay_dow, aes(y = delay_m), color = "red", 
             size = 5) + 
  coord_cartesian(ylim = c(-10, 100)) +
  scale_x_continuous(breaks = 1:7) +
  geom_hline(yintercept = mean(flights$dep_delay, na.rm = TRUE), 
             linetype = "dashed") +
  geom_hline(yintercept = median(flights$dep_delay, na.rm = TRUE), 
             linetype = "dashed") +
  geom_errorbar(aes(ymin = q_05, ymax = q_95), data = delay_dow) +
  theme_ipsum_rc() +
  scale_color_viridis_d()


## ----eval = FALSE-----------------------------
## flights %>%
##   select(dep_delay, hour) %>%
##   ggplot(aes(x = hour, y = dep_delay)) +
##   geom_boxplot(aes(group = hour)) +
##   geom_smooth(method = "lm") +
##   coord_cartesian(ylim = c(-10, 60))  +
##   scale_x_continuous(breaks = 1:24)
## 


## ----echo = FALSE-----------------------------
flights %>% 
  select(dep_delay, hour) %>% 
  ggplot(aes(x = hour, y = dep_delay)) +
  geom_boxplot(aes(group = hour)) +
  geom_smooth(method = "lm") +
  coord_cartesian(ylim = c(-10, 60))  +
  scale_x_continuous(breaks = 1:24)
  


## ---------------------------------------------
lm_hour <- lm(dep_delay ~ hour + month + origin + I(dow == 7), 
              data = flights)

rsquared(lm_hour)


## ---------------------------------------------
data("airports")

flights_airports <-  # join destination long/lat
  flights %>% 
  left_join(airports, by = c("dest" = "faa")) %>%  
  rename(long = lon)

origin_latlong <-
  airports %>% 
  filter(faa %in% c("LGA", "JFK", "EWR")) %>% 
  rename(lat_origin = lat,
         long_origin = lon)
  
flights_airports <-  # join origin long/lat
  flights_airports %>%
  left_join(origin_latlong, by = c("origin" = "faa"))


## ---------------------------------------------
flights_airports_sum <- flights_airports %>% 
  group_by(dest, origin) %>% 
  summarise(n = n(),
            long = max(long),
            lat = max(lat),
            long_origin = max(long_origin),
            lat_origin = max(lat_origin))


## ---------------------------------------------
head(flights_airports_sum)


## ----eval = FALSE-----------------------------
## ggplot(data = map_data("usa")) +
##   aes(x = long, y = lat, group = group) +
##   geom_path(color = "grey40", size = .1) +
##   geom_point(data = flights_airports_sum,
##              aes(size = n, color = n, group = NULL), alpha = .2) +
##   geom_segment(data = flights_airports_sum,
##                aes(color = n, group = NULL,
##                    x = long_origin, y = lat_origin,
##                    xend = long, yend = lat), alpha = .5) +
##   geom_text(data = flights_airports_sum %>% filter(n > 6000),
##             aes(x = long, y = lat, label = dest, group = NULL),
##             color = "grey40") +
##   theme_map() +
##   xlim(-130, -70) + ylim(+20, +50) +
##   scale_color_viridis()


## ----echo = FALSE, out.width="80%", fig.asp = 0.618----
ggplot(data = map_data("usa")) +
  aes(x = long, y = lat, group = group) +
  geom_path(color = "grey40", size = .1) +
  geom_point(data = flights_airports_sum, 
             aes(size = n, color = n, group = NULL)) +
  geom_segment(data = flights_airports_sum, 
               aes(color = n, group = NULL,
                   x = long_origin, y = lat_origin,
                   xend = long, yend = lat)) +
  geom_text(data = flights_airports_sum %>% filter(n > 6000), 
            aes(x = long, y = lat, label = dest, group = NULL),
            color = "grey40") +  
  theme_map() +
  xlim(-130, -70) + ylim(+20, +50) +
  scale_color_viridis() +
  theme(legend.position = "bottom")


## ----echo = TRUE, out.width="20%"-------------
data(mtcars)
purrr::map(select(mtcars, 1:2), ~ {ggplot(mtcars, aes(x = .)) +
    geom_histogram()})


## ----eval = FALSE-----------------------------
## flights %>%
##   select_if(~!is.numeric(.)) %>%
##   map2(., names(.), ~
##          {ggplot(data = flights, aes(x = .x)) +
##              geom_bar() + labs(x = .y, title = .y)})



## ----echo = TRUE, fig.asp = .8, out.width="30%"----
mtcars %>% 
  select_if(is.numeric) %>% 
  gather(key = variable, value = value) %>% 
  ggplot(aes(x = value)) +
  geom_density() +
  facet_wrap(~ variable, ncol = 3, scales = "free")


## ----fig.asp = .617---------------------------
library(hrbrthemes)

p2 <- p1 + theme_ipsum() + theme(legend.position = "bottom")
p2



## ----fig.width=10-----------------------------
library(patchwork)

p2 + p2


## ----echo = FALSE-----------------------------
R.Version()$version.string

si <- sessionInfo()
save(si, file = "si.RData")

