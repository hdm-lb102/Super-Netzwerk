### SKRIPT SUPERMÄRKTE ###


## Zusammenfügen der Edge- und Nodelist

library(igraph)
el <- read.csv("https://raw.githubusercontent.com/hdm-lb102/Super-Netzwerk/master/01_Edgelist_finale%20Datenerhebung.csv", header=T, as.is=T, sep = ",")
nodes <- read.csv("https://raw.githubusercontent.com/hdm-lb102/Super-Netzwerk/master/02_Nodelist_finale%20Datenerhebung.csv", header=T, as.is=T, sep = ",")
head(el)
head(nodes)

# igraph-Objekt aus edgelist erstellen
hties <-as.matrix(el)

super <- graph_from_data_frame(d=hties, vertices=nodes, directed=T)
plot(super)


# Anpassung der Knotengröße nach Degree-Wert !!!!Degree-Wert vergrößern?!!!

ds <- degree(super)
par(mfrow=c(1,1))
plot(super, vertex.size=ds)


E(super)$arrow.size <- .2 # definiert die Pfeilspitze auf 20% des Ursprungswerts
E(super)$color="black" # definiert die Kantenfarbe auf schwarz
plot(super)

#######################################################
#!!!!!!!? Dicke der Kanten
E(super)$relationship <- E(super)$weight

# simplify-Befehl: addiert edges auf, wenn sie auf der gleichen Beziehung liegen
# So sieht die Verteilung der Gewichtungen bislang aus:
edge.attributes(super)$relationship

# Achtung: nur verwenden, wenn Sie tatsächlich auch in der edgelist in numerisches weight angelegt haben

kanten <- simplify(super, edge.attr.comb = list(relationship="sum"))
edge.attributes(kanten)$relationship
# die weights im Netzwerk s1 wurden aufaddiert, sofern sie die gleiche Kante betroffen haben. Damit werden die auswertungen vereinfacht.
#######################################################


# Farben der Knoten (Supermarkt-Gruppen)

farben <- c("palegreen", "red3", "goldenrod1", "royalblue3", "yellow")
V(super)$color <- farben[V(super)$zugehoerigkeitdermarke]
plot(super, vertex.size=ds)



# Teilnetzwerke pos + neg erstellen und nebeneinander legen

par(mfrow=c(1,2))
snegativ <- subgraph.edges(super, E(super)[relationship < "3"])
spositiv <- subgraph.edges(super, E(super)[relationship > "2"])
E(snegativ)$color <- "red"
plot(snegativ)
E(spositiv)$color <- "green"
plot(spositiv)


