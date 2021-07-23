#Srapper TJGO
#Autor: Marcello Filgueiras

library(tidyverse)


# Baixando decisões -------------------------------------------------------

library(httr)
library(xml2)

url_inicial_tjgo <- "https://www.tjgo.jus.br/jurisprudencia/juris.php"

url_completo_tjgo <- "https://www.tjgo.jus.br/jurisprudencia/juris.php?acao=query&tipo=P&posicao="


# Transformando body TJGO -----


# buscando por
#busca <- "dissolucao parcial sociedade"

q_inicial_tjgo<- abjutils::chrome_to_body("acao: query
tipo: P
posicao: ")


body <- abjutils::chrome_to_body("banco: 
seguranca: ok
SearchAction: 3
SearchText: dissolucao parcial sociedade
SearchOption: and
SearchField: ds_todos
SearchActionAX: 3
nrrecursoX: 
dsrecursoX: 
decisaoX: 
ementaX: 
relatorX: 
comarcaX: 
dtacordaoX: 
SearchOption1X: and
SearchOption2X: and
SearchOption3X: and
SearchOption4X: and
SearchOption5X: and
SearchOption6X: and
SearchOption7X: and
button1: Pesquisar
posicao: 
data: 
totregistros: 
acao: query
tipo: P")

# Com a Query dentro do POST dá um erro no curl:

#Error in curl::curl_fetch_disk(url, x$path, handle = handle) : 
#URL using bad/illegal format or missing URL

request_inicial <- httr::POST( url_inicial_tjgo ,
            query= q_inicial_tjgo,
            body = body,
            write_disk(path = paste("data_raw/",
                                     Sys.time() %>%
                                        str_replace_all(pattern = " |-|:", replacement =  "_"),
                                     ".html",
                                     sep = "")
            ))

request_inicial_2 <-  httr::POST( url_completo_tjgo ,
                                  #query= q_inicial_tjgo,
                                  body = body,
                                  write_disk(path = paste("data_raw/",
                                                          Sys.time() %>%
                                                            str_replace_all(pattern = " |-|:", replacement =  "_"),
                                                          ".html",
                                                          sep = "")
                                  ))

#Com a Query já URL ele volta o site sem os parametros do BODY

content(request_inicial, simplfyDataFrame= TRUE)


            