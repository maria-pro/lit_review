library(tidyverse)

reflist<-read_csv("data/reflist-mp.csv", col_names=FALSE)

#test<-reflist%>%separate(X1, 
                  # into=c("a", "b", "c"),
                   sep="(\\.\\s(?![A-Z]{1}\\.\\s?))|(,\\s(?=\\d,\\s))",
                   into=c("authors", "year", "title", "journal", "rest")
                   #"[()]"
                   )
#test<-strsplit(reflist$X1, "[(]")


#test2<-do.call(rbind, lapply(test, function(x) do.call(rbind, x)))


d#ata.table::rbindlist(test, fill = TRUE)

#class(test)


#^([\w\s.,&]+)\s\((\d{4})\)\.\s([\w\s.,:]+),\s\d+,\s\d+\.?$
  
#  str <- "Brand, M., Laier, C., & Young, K. S. (2014). Internet addiction: Coping styles, expectancies, and treatment implications. Frontiers in Psychology, 5, 1256."


reflist$authors <- sub( " \\(.*", "", reflist$X1)

#-----------------
reflist$year <- sub(".*\\s\\(", "", reflist$X1) 

reflist$year <- sub("\\).*","", reflist$year)

years<-reflist%>% count(year, sort=TRUE)
#----------
reflist$title <- sub(".*\\d+\\). ", "", reflist$X1) 

reflist$title <- sub("\\..*", "", reflist$title)


#----------

reflist$journal <- sub(", \\d+.*", "", reflist$X1) 
  
reflist$journal <-sub(".*\\. ", "", reflist$journal)

#replace & with and as in scimagor list

reflist$journal<-str_replace_all(reflist$journal, "&", "and") 


#remove all numbers and special symbols

reflist$journal<- gsub('[0-9.]', '', reflist$journal)
reflist$journal<-str_replace_all(reflist$journal, ":-", "") 

reflist$journal<-str_replace_all(reflist$journal, " , e", "") 

reflist$journal<-str_replace_all(reflist$journal, "\\(\\):e", "") 

reflist$journal<-str_replace_all(reflist$journal, "\\(\\)\\:", "") 

reflist$journal<-str_replace_all(reflist$journal, "\\s\\(\\)", "") 

reflist%>%write_csv("reflist_mp_separated.csv") 


  
  
reflist%>%filter(journal %in% scimagor$Title)
not_in<-reflist%>%filter(!journal %in% scimagor$Title)


#---------

reflist%>%write_csv("reflist_separate.csv")

scimagor<-read_delim("data/scimagojr 2021.csv", delim = ';')
