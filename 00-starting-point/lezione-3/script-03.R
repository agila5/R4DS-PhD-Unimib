###########################################################################
################# Livellamento al Software R - Lezione 3 ##################
###########################################################################

# 1. Liste ----------------------------------------------------------------

# Le liste rappresentano una generalizzazione del concetto di vettore in quanto
# possono contenere elementi di tipo diverso. Sono chiamate anche strutture
# "ricorsive" in quanto una lista puo' contenere anche un'altra lista:
list(FALSE, 0L, pi, "ABC")
list(list(1, 2), matrix(1:3))

# La funzione str() e' molto utile per analizzare una lista e le sue componenti.
x <- list(1, "A", matrix(1:4, 2, 2))
x
str(x)

# Il subset (e il subset-assignment) di liste funziona in maniera leggermente
# diversa da quello per i vettori. In particolare:
x[2]

# restituisce UNA LISTA che contiene solamente il secondo elemento. D'altro
# canto
x[[2]]

# estrae il secondo dalla lista.

# Di conseguenza
det(x[3])
det(x[[3]])

# Una spiegazione molto bella su questo argomento:
# https://r4ds.had.co.nz/vectors.html#visualising-lists

# Per eliminare un elemento da una lista posso assegnare NULL al corrispondente
# indice.
str(x)
x[[1]] <- NULL
str(x)

# Gli elementi di una lista possono essere nominati
(y <- list(a = 1, b = "U5"))

# e posso utilizzare tali nomi per estrarre parti di una lista
y$a
y$b
y[["a"]]

# NB: Tantissime funzioni in R (e.g. lm()) restituiscono output di tipo lista.

rm(list = ls())

# 2. Valori mancanti (NA e NaN) -------------------------------------------

# In R si utilizza la costante NA (acronimo per Not Available) per indicare un
# valore mancante, indefinito o non specificato. Ad esempio:
c("Andrea" = 29, "Marco" = 27, "Luca" = NA)

# La funzione is.na() restituisce un vettore logico che identifica quali degli
# elementi in input sono NA:
x <- c(1, 2, NA)
is.na(x)
x[!is.na(x)]
na.omit(x)

# NB: Non e' possibile confrontare NA(s) con l'operatore di uguaglianza logica:
NA == NA

# Perche'? NA rappresenta un placeholder per un valore non noto. Di conseguenza,
# non potendo sapere se i due valori mancanti sono uguali o meno, R restituisce
# NA.

# Analogamente, la seguente operazione "non funziona":
x == NA

rm(list = ls())

# 3. Funzioni di probabilita' ----------------------------------------------

# Il software R implementa un insieme di funzioni aventi una sintassi comune per
# gestire particolari variabili casuali. Ad esempio, se assumiamo che X
# rappresenta una variabile casuale Gaussiana a media mu = 0 e deviazione
# standard sigma = 1, il seguente comando genera n = 5 realizzazioni casuali da
# X:
rnorm(n = 5, mean = 0, sd = 1)

# NB1: E' importante distinguere tra una variabile casuale e le sue
# realizzazioni. Di conseguenza, nel precedente esempio, X rappresenta la
# generica v.c. mentre rnorm estrae 5 realizzazioni aleatorie.

# Per calcolare la CDF di X in un punto q, e.g. P(X <= 0), possiamo usare
pnorm(q = 0, mean = 0, sd = 10)

# mentre qnorm calcola i quantili di X
qnorm(p = 0.975, mean = 0, sd = 1)

# e dnorm i valori della funzione di densita'
dnorm(x = 0.5, mean = 0, sd = 1) # uguale a 1/sqrt(2 * pi) * exp(0)

# Tutte queste funzioni seguono un pattern comune. La prima lettera identifica
# l'obiettivo della funzione:
# - d per la funzione di densita'
# - p per calcolare la CDF
# - q per calcolare i quantili
# - r per generare numeri casuali (random)

# mentre le rimanenti lettere descrivono la variabile casuale (e.g. norm per la
# Normale, pois per la Poisson, gamma per la Gamma, unif per l'Uniforme e cosi'
# via).

# Check
?Distributions

# NB: Come si puo' intuire dall'output delle precedenti funzioni, i comandi del
# tipo r* restituiscono ogni volta una realizzazione casuale diversa. La
# variabile casuale puo' rimanere invariata, ma le estrazioni da essa solo
# aleatorie. Per garantire la riproducibilita' dei risultati tra sessioni o PC
# diversi, potrebbe essere utile fissare un "seme" per garantire sempre le
# stesse realizzazioni casuali:

runif(1)
runif(1)

set.seed(1)
runif(1)
set.seed(1)
runif(1)

# La generazione di estrazioni casuali da una variabile casuale e' un argomento
# molto interessante e complesso. Purtroppo non possiamo aggiungere dettagli
# ulteriori, ma vi invito a consultare il libro "The R Software" se volete
# leggere ulteriori dettagli.

# Per concludere questa sezione riportiamo una citazione secondo me molto
# divertente:

# "The generation of random numbers is too important to be left to chance."
# > Robert R. Coveyou

# 4. Grafici di base ------------------------------------------------------

# 4.1 plot() --------------------------------------------------------------

# La funzione R piu' semplice (e, probabilmente, anche la piu' importante) per
# creare un grafico e' plot(). Il suo comportamento dipende dalla "classe" degli
# oggetti che vengono passati in input (vedi ?plot e sezione 5/6 di questo
# script).

# Il primo grafico che andiamo a creare e' uno "scatter plot":
x1 <- 1:10
y1 <- 10:1
plot(x1, y1)

# Vediamo che il grafico viene mostrato nella console denominata "Plots" la
# quale, di default, e' nel pannello in basso a dx di Rstudio.

# Dalla pagina di help ?base::plot leggiamo quanto segue:
# > For simple scatter plots, plot.default will be used.

# e, dalla pagina di help ?plot.default vediamo che la funzione accetta diversi
# argomenti (descritti nella sezione Arguments) e diversi "graphical parameters"
# (descritti nella sezione Details) per modificare ed aggiustare l'aspetto di un
# grafico. Ad esempio:
plot(x1, y1, col = "red", cex = 2, pch = "+", xlab = "Hi!", ylab = "", main = "My second plot!")

# Tipicamente, ogni volta che eseguiamo la funzione plot() viene generato un
# grafico nuovo. Per aggiungere un "nuovo" insieme di punti ad un grafico
# esistente possiamo usare la funzione "points()":
x2 <- runif(100, min = 0, max = 10)
y2 <- runif(100, min = 0, max = 10)
points(x2, y2, col = "blue", cex = 2, pch = 20)

# D'altro canto, se vogliamo rappresentare i due insiemi di punti in due grafici
# distinti nello stesso pannello dobbiamo modificare il parametro "mfrow" (o
# "mfcol"):
old_par <- par(mfrow = c(2, 1)) # vogliamo una matrice di grafici con 1 riga e 2 colonne riempita per riga
plot(x1, y1, type = "b", col = "red", cex = 2, pch = 20)
plot(x2, y2, col = "blue", cex = 2, pch = 20)

# NB: la funzione layout() puo' essere utilizzata per definire layout grafici
# molto piu' complessi di quelli creabili tramite "mfrow" e "mfcol". Se volete
# leggere piu' dettagli, vi rimando alla pagina di help ed alla sezione 7.1.2 di
# "The R Software".

# Per "cancellare" tutti i grafici salvati in memoria da Rstudio possiamo usare
dev.off()

# e, per resettare i vecchi parametri grafici:
par(old_par)

# oppure
par(mfrow = c(1, 1))

# elenco di tutti i parametri grafici e della sessione R
par()

