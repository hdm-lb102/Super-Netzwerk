### SKRIPT SUPERMÄRKTE ###


## laden igraph, edge- und nodelist

library(igraph)
library(igraphdata)
el <- read.csv("https://raw.githubusercontent.com/hdm-lb102/Super-Netzwerk/master/Abgabe%20Datensatz/Edgelist_aufaddiert", header=T, as.is=T, sep = ",")
nodes <- read.csv("https://raw.githubusercontent.com/hdm-lb102/Super-Netzwerk/master/Abgabe%20Datensatz/Nodelist", header=T, as.is=T, sep = ",")
head(el)
head(nodes)



## igraph-Objekt aus edgelist erstellen

hties <-as.matrix(el)
super <- graph_from_data_frame(d=hties, vertices=nodes, directed=T)
plot(super)




## Zusammengefasste Kanten (händisch aufaddiert) über das weight der edges visualisieren

list.edge.attributes(super)
list.vertex.attributes(super)


edge.attributes(super)$weight
E(super)$width <- E(super)$weight




## Zuweisung Layout

install.packages("visNetwork")
library(visNetwork)

# Zuweisung Kanten

E(super)$arrow.size <- .2
E(super)$color="grey"


# Zuweisung der Knoten-Farben (Supermarkt-Gruppen)

farben <- c("#2EFE64", "#F5A9A9", "#FAAC58", "#A9F5F2", "#F2F5A9")
V(super)$color <- farben[V(super)$zugehoerigkeitdermarke]


# Anpassung der Knotengröße

ds <- degree(super)
V(super)$size <- ds*2

V(super)$frame.color <- "transparent"
V(super)$label.color <- "black"
V(super)$label.family <- "Helvetica"

##bitte noch rausfinden wie man Überschrift einblenden kann und evtl. Knotennamen in Kreis sezten?
main="Gesamtnetzwerk Supermärkte"

visIgraph(super, physics=F, type = "full")



## Teilnetzwerke pos. + neg. erstellen und nebeneinander legen

par(mfrow=c(1,2))
snegativ <- subgraph.edges(super, E(super)[relationship < "3"])
spositiv <- subgraph.edges(super, E(super)[relationship > "2"])

E(snegativ)$color <- "red"
plot(snegativ)

E(spositiv)$color <- "green"
plot(spositiv)



## Netzwerkanalyse

# ?Welcher Supermarkt wird am häufigsten erwähnt(Popularität)?
inds <- degree(super, mode="in")
inds
# !Antwort: Lidel mit Wert 16.

# ?Welcher teilt am meisten aus(Outdegree)?
outds <- degree(super, mode="out")
outds
# !Antwort: Aldi mit Wert 22


# Vergleich Indegree & Outdegree

# Penny & Netto werden in gleichem Maße erwähnt und geben Erwähnungen ab.
# Real hat als einziger Supermarkt keine Aktivität nach außen.


## bitte noch rausfinden wie Dichte des Netzwerks angezeigt werden kann.
#Wie hoch ist die Interaktion aller Supermärkte (Dichte)?

density(super)
