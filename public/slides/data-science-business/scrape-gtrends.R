

library(gtrendsR)
library(tidyverse)
library(glue)

stats_terms <- c("statistical modeling", 
                 "machine learning",
                 "data mining",
                 "predictive modeling",
                 "artificial intelligence")


stats_terms2 <- c("Data science",
                  "Predictive analytics")

s <- gtrends(keyword = stats_terms,
             gprop = "web")

s2 <- gtrends(keyword = stats_terms2,
             gprop = "web")

d <- s$interest_over_time

d <- d %>% 
  mutate(hits = parse_number(hits))


d2 <- s2$interest_over_time


d_all <- bind_rows(d, d2)


d_all <- d_all %>% 
  mutate(hits_num = parse_number(hits))


write_csv(d_all, glue("data/gtrends-{lubridate::today()}.csv"))



d_all %>% 
  ggplot(aes(x = date, y = hits, color = keyword)) +
  geom_line() +
  geom_smooth(se = FALSE)
