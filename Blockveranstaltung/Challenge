# Challenge
# Tag 3
# Wenn Sie die Anforderungen erfüllt haben und Ihr Skript mit Lösungen auf Moodle hochgeladen haben, können Sie gehen (alternativ natürlich mir noch Fragen stellen!)

# Aufgabe: Beantworten Sie mit einer Visualisierung aus dem vorgegebenen Studentennetzwerk folgende Fragen:

# 1. Welche Personen sind im Arbeits- und Unterstützungsnetzwerk am populärsten? (Wer wird am meisten um Rat gefragt? Mit wem wird am liebsten zusammengearbeitet?) Sind es die gleichen Personen? Die Visualisierung soll beide Netzwerke vergleichen (beide Visualisierungen mit Überschriften nebeneinander.

# 2. Sind Raucher stärker in Triaden/Cliquen zu finden als Nicht-Raucher? Führen Sie einen Dyadenzensus durch. Belegen Sie dies mit einem Ego-Netzwerk der am besten vernetzten Raucher. Wer ist direkt mit dem Raucher verbunden? Sind Raucher die besseren Broker zwischen Netzwerken? (Tipp: Betweenness).
# Bonus-Frage: Sind Raucher/innen auch tätowiert? Wenn ja, wie viele?

# 3. Welche Vertiefungsrichtung arbeitet mehr/weniger? CR oder PR? Visualisieren Sie das bitte mit einem Farbverlauf (Tipp: Sie müssen vorher die Netzwerke trennen)
library("igraph")
el <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/edges.csv", header=T, as.is=T, sep = ",")
nodes <- read.csv("https://raw.githubusercontent.com/hdm-crpr/226305/master/data/students/nodes.csv", header=T, as.is=T, sep = ",")
eties <-as.matrix(el)
s <- graph_from_data_frame(d=eties, vertices=nodes, directed=T)
s

# Selektion in Teilnetzwerk cr und pr
vertex.attributes(s)

vertex.attributes(s)$crpr
# das vertex attribut cr pr ist in 1 und 2 kodiert.
# 1 ist CR, 2 ist PR

cr <- subgraph.edges(s, V (s)[crpr == 1])
cr

plot(cr, edge.arrow.size=0.1, main="CR-Netzwerk")


pr <- subgraph.edges(s, V (s)[crpr == 2])
pr

plot(pr, edge.arrow.size=0.1, main="PR-Netzwerk")

jobcr <- V (cr)$job
jobcr

jobpr <- V (pr)$job
jobpr

library('RColorBrewer')
# Mit der Color-Brewer Bibliothek lassen sich schon vorgefertigte Farbverläufe anzeigen. Beispielseweise ist dies ein Farbverlauf für die Farbwelt "blues" mit 12 Abstufungen.
display.brewer.pal(12, "Blues")

# Diese Abstufung kann leicht manipuliert werden, da er durch den Zahlenwert angegeben ist.
display.brewer.pal(4, "Blues") # Vier Abstufungen "blau"
display.brewer.pal(8, "Oranges") # Acht Abstufungen "blau"

# Damit wir die Abstufung der Farbpalette richtig auf die Verteilung der Werte zuordnen können, müssen diese entsprechend sortiert werden

col=heat.colors(4)
V(cr)$color <- col[jobcr]
plot(cr, edge.color="grey", edge.arrow.size=.1)

# Das klappt schon ganz gut, nur passen die Skala der Arbeitsstunden (von 0 bis 4) und die der Farbwerte noch nicht zusammen.

# gibt an, wie viele Schritte die Farbskala haben soll
fine = 4


# Farbverlauf für PR-Netzwerk
col=heat.colors(4)
V(pr)$color <- col[jobpr]
plot(pr, edge.color="grey", edge.arrow.size=.1)

# Das klappt schon ganz gut, nur passen die Skala der Arbeitsstunden (von 0 bis 4) und die der Farbwerte noch nicht zusammen.

# gibt an, wie viele Schritte die Farbskala haben soll
fine = 4


par(mfrow=c(1,2), mar=c(0,0,2,0))
plot(cr, layout = layout_with_kk, edge.arrow.size=0.1, main="CR-Arbeiter")
plot(pr, layout = layout_with_kk, edge.arrow.size=0.1, main="PR-Arbeiter")

vertex.attributes(cr)$job
vertex.attributes(s)

# 4. Vergleichen Sie die Cluster des Arbeits- und Ratsuche-Netzwerk, nachdem Sie die Gewichte der jeweiligen Netzwerke mit dem simplify Befehl aufaddiert haben. Visualisieren Sie die Cluster nebeneinander mit dem walktrap Algorithmus. Was fällt Ihnen dabei auf.

# Bitte laden Sie das R-Skript mit Antworten auf die Fragen auf Moodle hoch.


# Bitte verwenden ausschließlich folgenden Datensatz
# Codebuch ist hier hinterlegt
# https://github.com/hdm-crpr/226305/blob/master/data/students/codierung.rmd


