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

E(snegativ)$color <- "firebrick"
plot(snegativ, vertex.frame.color = "transparent", vertex.label.family = "Helvetica", vertex.label.color = "black")

E(spositiv)$color <- "olivedrab1"
plot(spositiv, vertex.frame.color = "transparent", vertex.label.family = "Helvetica", vertex.label.color = "black")



## Netzwerkanalyse

# ?Welcher Supermarkt wird am häufigsten erwähnt(Popularität)?
inds <- degree(super, mode="in")
inds
# !Antwort: Lidl mit Wert 16.

# ?Welcher teilt am meisten aus(Outdegree)?
outds <- degree(super, mode="out")
outds
# !Antwort: Aldi mit Wert 22


# Vergleich Indegree & Outdegree

# Penny & Netto werden in gleichem Maße erwähnt und geben Erwähnungen ab.
# Real hat als einziger Supermarkt keine Aktivität nach außen.


#Wie hoch ist die Interaktion aller Supermärkte (Dichte)? ##FALSCH?
edge_density(super, loops = FALSE)
# Antwort: sehr dichtes Netzwerk, Gründe: nur 8 Knoten, keine isolierten Knoten, immer mind. 2 relations

# Wie viele reziproke Beziehungen gibt es im Verhältnis zu allen Beziehungen?
reciprocity(super)
# Antwort: Ca. 57% der Beziehungen zwischen den Supermärkten sind reziprok. 
# D.h. Supermärkte erwähnen sich gegenseitig, aber nicht so häufig wie erwartet. 
# Es gibt keine reinen "Austeiler", lediglich Real ist ein reiner "Empfänger" und erwähnt keine anderen Supermärkte.
