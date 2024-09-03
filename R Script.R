install.packages("here")
here::here("data","wc_matches.csv")

matches <- read.csv(here::here("data", "wc_matches.csv"))

install.packages("gtsummary")
library(gtsummary)
library(dplyr)

matches <- read.csv(here::here("data", "wc_matches.csv"))


matches <- rename(matches, home = team1, away = team2)
matches <- matches %>% mutate(winner = ifelse( score1 > score2, 1, 0))

tbl_summary(
	matches,
	by = winner,
	include = c(prob1, prob2, xg1, xg2, spi1, spi2))

tbl_uvregression(
	matches,
	y = winner,
	include = c(prob1, prob2, xg1, xg2, spi1, spi2),
						method =glm)
