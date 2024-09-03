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
	include = c(prob1, prob2, xg1, xg2, spi1, spi2),
	label = list(
		prob1 ~ "Probability of Home Win",
		prob2 ~ "Probability of Away Win",
		xg1 ~ "Home Team Expected Goals",
		xg2 ~ "Away Team Expected Goals",
		spi1 ~ "Home Team Soccer Power Index",
		spi2 ~ "Away Team Soccer Power Index"
	))

tbl_uvregression(
	matches,
	y = winner,
	include = c(prob1, prob2, xg1, xg2, spi1, spi2),
						method =glm)

hist(expected_goals)

mean_goals <- function(x){
	n <- length(x)
	mean_val <- sum(x) / n
	return(mean_val)
}
x <- c(matches$score1, matches$score2)
mean_goals(x)
