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

ticker <- c("aapl", "tsla", "meta", "achr", "joby", "rklb", "shop", "sound", "phun", "nvda", "smci", "nflx", "gtlb", "googl", "amzn", "pltr", "msft", "orcl", "arkk", "snow", "amd", "crm", "crwd", "path", "twlo", "baba", "adbe") 

premarket_price <- map_chr(ticker, premkt_price) %>%
    parse_number()

closed_price <- map_chr(ticker, closed_price) %>%
    parse_number()

df <- tibble(ticker, closed_price, premarket_price, `gain/loss` = premarket_price - closed_price)

df %>% write_csv("market-watch.csv")
