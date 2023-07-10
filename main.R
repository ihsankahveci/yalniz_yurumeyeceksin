# libraries
library(rvest)
library(readr)
library(tibble)
library(dplyr)

source("scripts/scrapers.R")
options(scipen=99)

## retrieve all URLs and create a data.frame
main_url = "https://yalnizyurumeyeceksin.com/page/"
links_df = tibble()
for (page in 1:70){
  url = paste0(main_url, page, "/")
  links = get_links(url)
  if(length(links) == 0) next
  links_df = bind_rows(links_df, tibble(url = links))
}

## scrape parts of the post into different columns. 
all_df = links_df |> 
  rowwise() |> 
  mutate(
    title = get_title(url),
    date = get_date(url),
    text = get_text(url),
    comments = list(get_comments(url))) |> 
  ungroup()


## data cleaning 
final_df = all_df |> 
  mutate(date = parse_date(date, format = "%B %d, %Y", locale = locale("tr")))

write_csv(final_df, "data/yalniz_yurumeyeceksin.csv")
