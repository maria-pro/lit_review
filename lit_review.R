library(bibliometrix)

M <- convert2df(file = "data/p1.bib", dbsource = "isi", format = "bibtex")

# main bibliometric measures
results <- biblioAnalysis(M, sep = ";")

#summarize main results of the bibliometric analysis
options(width=100)
S <- summary(object = results, k = 10, pause = FALSE)


plot_res<-plot(x = results, k = 10, pause = FALSE)

#most frequent cited manuscripts
CR <- citations(M, field = "article", sep = ";")
cbind(CR$Cited[1:10])


#most frequent cited first authors
CR <- citations(M, field = "author", sep = ";")
cbind(CR$Cited[2:10])


#most frequent local cited authors
CR <- localCitations(M, sep = ";")
CR$Authors[1:10,]

CR$Papers[1:10,]

#Authors’ Dominance ranking
DF <- dominance(results, k = 10)
DF

#H index
indices <- Hindex(M, field = "author", elements="BENETOLI A", sep = ";", years = 10)

# Bornmann's impact indices:
indices$H


indices$CitationList

#Top-Authors’ Productivity over the Time
authors=gsub(","," ",names(results$Authors)[1:10])

indices <- Hindex(M, field = "author", elements=authors, sep = ";", years = 50)

indices$H


topAU <- authorProdOverTime(M, k = 10, graph = TRUE)

## Table: Author's productivity per year
head(topAU$dfAU)
