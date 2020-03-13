# install.packages("rvest")
# install.packages("xml2")

library(rvest)
library(dplyr)

# pegar título e nota de um filme
crawler_imdb <- function(imdb_url){
  
  movie <- read_html(imdb_url)
  
  # nota do filme
  rating <- movie %>% 
    html_nodes("strong span") %>%
    html_text() %>% 
    as.numeric()
  
  # nome do filme
  title <- movie %>% 
    html_nodes("h1") %>%
    html_text() 
  
  data.frame(titulo = title, nota = rating)
}

# criar uma tabela com os filmes
tabela_imdb <- function(filmes){
  tabela <- data.frame() # tabela em branco
  
  for(i in 1:length(filmes)){
    tabela <- tabela %>% 
      rbind(crawler_imdb(filmes[i]))
  }
  tabela %>% 
    arrange(-nota) # ordena os filmes pela nota
}

# links num unico objeto chamado filmes
filmes <- c("http://www.imdb.com/title/tt1490017/",
            "https://www.imdb.com/title/tt0133093/",
            "https://www.imdb.com/title/tt5180504/",
            "https://www.imdb.com/title/tt7286456/")


tabela_imdb(filmes)