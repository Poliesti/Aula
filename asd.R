#install.packages("rvest")
#install.packages("xml2")
#install.packages("dplyr")

library(rvest)
library(xml2)
library(dplyr)

lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")

rating <- lego_movie %>% 
  html_nodes("strong span") %>%
  html_text() %>% 
  as.numeric()

title <- lego_movie %>% 
  html_nodes("h1") %>% 
  html_text()

data.frame(titulo = title, nota = rating)

#########################################################################

crawler_imdb <- function(imdb_url){
  movie <- read_html(imdb_url)  
  
  rating <- movie %>% 
    html_nodes("strong span") %>%
    html_text() %>% 
    as.numeric()
  
  title <- movie %>% 
    html_nodes("h1") %>% 
    html_text()
  
  data.frame(titulo = title, nota = rating)
}

tabela <- crawler_imdb("https://www.imdb.com/title/tt7286456/")

filmes <- c("https://www.imdb.com/title/tt0133093/",
             "http://www.imdb.com/title/tt1490017", 
            "https://www.imdb.com/title/tt5180504/", 
            "https://www.imdb.com/title/tt3794354/")

tabela_imdb <- function(filmes){
  tabela <- data.frame()
  
  for(i in 1:length(filmes)){
    tabela <- tabela %>% 
      rbind(crawler_imdb(filmes[i]))
  }
  tabela
}