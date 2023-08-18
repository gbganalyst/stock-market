library(glue)
library(purrr)
library(tibble)
library(ralger)
library(readr)

premkt_price <- function(stock) {
    scrap(glue("https://www.marketwatch.com/investing/stock/{stock}?mod=search_symbol"), node = ".value")[1]
  }

closed_price <- function(stock) {
    scrap(glue("https://www.marketwatch.com/investing/stock/{stock}?mod=search_symbol"), node = ".u-semi")[1]
  }


stocks <- c("tsla", "meta", "pltr", "shop", "soun", "nvda", "nflx", "gtlb", "googl", "amzn", "msft", "arkk", "zm", "snow", "amd", "smci")

premarket_price <- map_chr(stocks, premkt_price) %>%
    parse_number()

closed_price <- map_chr(stocks, closed_price) %>%
    parse_number()

df <- tibble(stocks, closed_price, premarket_price, `gain/loss` = premarket_price - closed_price)

df %>% write_csv("market-watch.csv")
