###########################################################################
################# Livellamento al Software R - Lezione 2 ##################
###########################################################################

# 1. Operatori vettorizzati e recyling ---------------------------------

# Alcuni degli operatori matematici visti in precedenza (e.g. "+", "-", "*", "/"
# e cosi' via) sono definiti in maniera tale da essere applicati in modo
# vettorizzato su vettori o coppie di vettori di lunghezza maggiore o uguale ad
# 1. Ad esempio:
x <- c(1, 2, 3)
y <- c(4, 5, 6)

# La seguente operazione
(z <- x + y)

# restituisce un vettore i cui elementi sono ricavati sommando le coppie di
# valori in x ed y:
#                       z_i = x_i + y_i ; i = 1, ... 3

x - y
x * y
x / y
x ^ y

# L'operazione
(w <- sqrt(x))

# restituisce un vettore in cui elementi sono ricavati tramite la seguente
# espressione: w_i = sqrt(x_i);   i = 1, ..., 3

# Questa proprieta' rappresenta uno dei punti di forza principali del linguaggio.
# Infatti, le operazioni eseguite tramite operatori vettorizzati sono
# tipicamente molto piu' efficienti (da un punto di vista computazionale) di
# quelle che potremmo definire noi a mano. Di conseguenza, se possibile, sarebbe
# utile cercare di evitare di scrivere "cicli for" (e operazioni analoghe, come
# vedremo in seguito) preferendo l'utilizzo degli operatori vettorizzati.
# Chiaramente, cio' non e' sempre possibile ...

# Ma cosa succede quando una operazione vettorizzata viene applicata a due
# operatori che non hanno la stessa lunghezza? Ad esempio, cosa vi aspettate che
# sia il risultato della seguente operazione?
x <- c(1, 2, 3)
y <- c(4, 5)
x + y

# Vediamo che R restituisce un Warning message del tipo:
# In x + y : longer object length is not a multiple of shorter object length

# Vediamo che R ha "completato" il vettore piu' corto riciclando i suoi elementi
# (partendo dall'inzio) fino a raggiungere la lunghezza del vettore piu' lungo.
# Ancora:
x <- 1:8
y <- 1:3
x + y

# Questo comportamento chiamato anche "recyling" e' molto comodo in alcune
# situazioni 
x + 1 

# (il valore 1 viene replicato tante volte quanto e' la lunghezza di x) ma
# pericoloso (o quantomeno strano) in altre
x + c(1, 2)

# 2. La rappresentazione a virgola mobile -------------------------------------

# Uno degli operatori piu' comuni su R e' "==". Esso serve a testare
# l'uguaglianza tra due elementi. Ad esempio:
c(1L, 2L) == c(1L, 4L)

# Questo operatore deve essere usato con cautela quando vogliamo confrontare
# numeri rappresentati internamente come "double". Ad esempio:
x <- 0.1 * 0.1
y <- 0.01

x; y

# Tuttavia
x == y

# Perche'? Quando un computer deve definire internamente un numero reale x, egli
# utilizza una rappresentazione in base binaria esprimibile tramite un numero
# finito di bit. Di conseguenza, tranne che in pochi casi (e.g. i multipli di 2), 
# i numeri reali non possono essere salvati in memoria in forma esatta.

# La funzione formatC ci permette di chiarire meglio questo concetto forzando R
# a stampare i valori associati ad x ed y utilizzando un numero maggiore di
# cifre decimali:
formatC(x, 50)
formatC(y, 50)

# Per ovviare a questo problema, possiamo usare la funzione all.equal() la quale
# contiene un argomento chiamato "tolerance" che permette di testare
# l'uguaglianza di due vettori di tipo "double" a meno di un certo fattore di
# tolleranza:
all.equal(x, y)

# NB: Questo implica anche che un costrutto del tipo:

# if (x == 0) {...}

# puo' essere molto pericolo nel caso in cui x sia rappresentato internamente
# utilizzando un tipo "double". Meglio usare isTRUE(all.equal(x, 0)). 

# if (isTRUE(all.equal(x, 0))) {...}

# NB1: Questo non e' un problema unicamente di R ma e' intrinseco alla
# rappresentazione numerica utilizzata dai computer. Se volete piu' dettagli,
# provate a leggere quanto riportato al seguente link:
# https://cran.r-project.org/doc/FAQ/R-FAQ.html#Why-doesn_0027t-R-think-these-numbers-are-equal_003f

# NB2: Un video molto interessante sull'argomento:
# https://www.youtube.com/watch?v=3Bu7QUxzIbA&t=2s&ab_channel=RConsortium

# 3. I pacchetti R -----------------------------------------------------------

# Il software R viene distribuito con un insieme di pacchetti (tipicamente
# disponibili per diverse versione di R) che implementano le funzionalita'
# principali. Possiamo elencarli con il seguente comando:
installed.packages(priority = c("base", "recommended"))[, c("Package", "Priority")]

# Ad esempio: il pacchetto base definisce le funzioni "base" di R tra cui quasi
# tutti gli operatori matematici che abbiamo visto in precedenza (e.g. sign,
# sum, mean, +, -, sd, ...), la funzione "c" che abbiamo usato per concatenare
# elementi e creare un vettore, la funzione formatC per modificare il printing
# di un oggetto, ... Il pacchetto "cluster" definisce funzioni per la cluster
# analysis, "nnet" e "spatial" implementano dei metodi di base per l'analisi di
# reti neurali e dati spaziali, e cosi via...

# Un punto di forza del linguaggio R e' la sua comunita' e l'enorme
# disponibilita' di pacchetti aggiuntivi che permettono di estendere il
# linguaggio ed ampliare le capacita' del software. Infatti, un "pacchetto R"
# non e' altri che un insieme di funzioni e dati che ci permette di utilizzare il
# software per nuovi obiettivi. Questi pacchetti sono tipicamente disponibili
# tramite un archivio centrale chiamato CRAN (Central R Archive Network):
# https://cran.r-project.org/

# Per utilizzare un pacchetto che non e' tra quelli di default, innanzitutto e'
# necessario installarlo:
install.packages("reprex")

# Successivamente, per utilizzare le funzionalita' extra definite in tale
# pacchetto, dobbiamo caricarlo:
library("reprex")

# NB: E' necessario installare un pacchetto R solo una volta, mentre dobbiamo
# caricarlo ogni volta che apriamo una nuova sessione di R.

# Come chiedere aiuto online su R?

# - Mailing lists: https://www.r-project.org/mail.html
# - Github pages
# - Stack Overflow: https://stackoverflow.com/questions/tagged/r
# - Messaggi privati agli sviluppatori

# Un altro pacchetto R (poco utile ma molto divertente da usare) e' "fortunes":
install.packages("fortunes")
library(fortunes)
fortune(124L)
fortune(107L)

# Provate a consultarne un po' a random...
fortune()

# 4. Stringhe -------------------------------------------------------------

# Il linguaggio R utilizza il tipo "character" per rappresentare internamente
# le stringhe di testo. Ad esempio:

"ABC"

# oppure

'ABC'

# Come mostrato sopra, le stringhe devono essere delimitate dai caratteri "
# oppure '. Possiamo concatenare una o piu' stringhe di testo per creare un
# vettore di tipo "character":
x <- c("rosso", "verde", "giallo")

# ma anche
c("1", "2", "3") # NB: anche i "numeri" li possiamo rappresentare come stringhe

# oppure
y <- c("come un peperone", "di rabbia", "d'invidia")

# Sono gia' implementate diverse funzioni per manipolare vettori di tipo
# character. Ad esempio:

nchar(x) # il numero di caratteri che compongono una stringa
paste(x, y) # concatenazione di stringhe elemento per elemento.
substring(x, 1, 2) # subsetting
grep("giallo", x); grepl("giallo", x) # matching
gsub("o", "*", x) # replacement

# Possiamo anche convertire una stringa di testo in maiuscolo/minuscolo
toupper(x)
tolower(toupper(x))

# Inoltre, il pacchetto R "tools" definisce una funzione chiamata "toTitleCase"
# che permette di scrivere una stringa di testo come se fosse il titolo di 
# un lavoro:
library(tools)
toTitleCase(x)
toTitleCase("andrea and marco go to the beach")
toTitleCase("andrea e marco vanno in spiaggia")

# NB: Questa funziona e' ottimizzata per il testo scritto in inglese.

# La gestione delle stringhe di testo su R e' un argomento molto complesso e,
# data la natura del corso di livellamento, ci fermiamo qua. Alcune
# precisazioni:
#
# - Per effettuare operazioni piu' articolate di quelle descritte in precedenza,
# si e' soliti utilizzare espressioni chiamate "regex" (acronimo di REGular
# EXpression): pattern che descrivono le caratteristiche di una stringa
# testuale. Ad esempio, il seguente comando serve per sostituire il primo
# carattere di una stringa di testo con "*" a meno che questo carattere sia
# uguale ad "r".
gsub("^[^r]{1}", "*", x)

# Se volete approfondire l'argomento, vi suggerirei di consultare la
# corrispondente pagina di help (?regex), il seguente capitolo
# https://r4ds.had.co.nz/strings.html ed il seguente sito web:
# https://regex101.com/

# NB: Tranne che nei casi' piu' banali, la costruzione di una regex e'
# abbastanza complessa
# (https://www.reddit.com/r/ProgrammerHumor/comments/lea26p/the_plural_of_regex_is_regrets/)
# ma sono strumenti molto potenti.

# - Le operazioni sulle stringhe di testo dipendono molto dalla lingua (e, piu'
# in particolare, dal "locale") che viene utilizzato. Anche in questo caso vi
# rimando a https://r4ds.had.co.nz/strings.html#locales.

# La funzione is.character() serve per testare se l'input e' un vettore di tipo
# character.
is.character(x)
is.character(42L)

# La funzione strsplit serve a dividere ogni elemento di un vettore di stringhe
# rispetto ad un dato pattern:
strsplit(y, " ")

# L'output di questa funzione e' una lista, una delle strutture dati piu'
# importanti di R che verra' introdotta nella lezione 3.

rm(list = ls())

# 5. Fattori --------------------------------------------------------------

# Il linguaggio R implementa una struttura dati chiamata "factor" che facilita
# l'analisi di dati categoriali. I factor sono particolarmente utili per
# rappresentare variabili che possono assumere solo una categoria tra un insieme
# noto e finito di valori (e.g. il genere, la tipologia di impiego, il mese di
# nascita, ...). I valori possono avere un ordinamento (e.g. le gerarchie in
# ambito militare) oppure no (e.g. il colore dei capelli).

# Per creare un oggetto factor possiamo usare la funzione omonima:
elenco_giorni <- c(
  "Lunedi", "Martedi", "Mercoledi", "Giovedi", "Venerdi", "Sabato", "Domenica"
)
factor(c("Lunedi", "Domenica"), levels = elenco_giorni)

# Se non specifico l'argomento "levels", allora i livelli vengono generati
# automaticamente prendendo le stringhe univoche in input in ordine alfabetico:
factor(c("Lunedi", "Domenica"))

# Per specificare che i possibili valori sono definiti secondo una gerarchia,
# posso usare l'argomento ordered:
gradi_esercito <- c("soldato", "luogotenente", "capitano", "generale")
x <- c("soldato", "soldato", "capitano")
factor(x, levels = gradi_esercito, ordered = TRUE)

#NB: La variabile month.abb (gia' salvata in memoria) continene il nome
#abbreviato dei mesi dell'anno (secondo il locale utilizzato):
month.abb

rm(list = ls())

# 6. Coercizione ----------------------------------------------------------

# Come detto nella lezione precedente, in R un vettore non e' altro che una
# sequenza di valori aventi lo stesso tipo. La funzione "c" serve per
# concatenare gli elementi di un vettore. Ma cosa succede quando proviamo a
# concatenare elementi di tipi diversi? Ad esempio, cosa restituisce il seguente
# comando?
c(FALSE, 1, "A")

# Come riportato nella help page della funzione "c":

# > The output type is determined from the highest type of the components in the
# hierarchy:
# ... < logical < integer < double < complex < character < list < ...

# In altre parole, in R esiste una gerarchia tra i vari tipi ed ogni volta che
# mischiamo tipi diversi, l'output viene trasformato secondo il tipo piu' in alto
# nella gerarchia.

# In R esistono diverse funzioni che permettono di effettuare una conversione
# esplicita tra tipi diversi. Seguono tutte la sintassi "as.*tipo*". Ad esempio:
as.numeric(c("1", "2", "3.14")) # numeric vuol dire double o integer

# oppure
as.character(c(pi, TRUE))
as.character(TRUE)

# Nel caso in cui la conversione non sia opportunamente definita, R restituisce
# un valore mancante (o NA, vedi lezione 3) ed un messaggio di warning:
as.numeric("123.456")
as.numeric("mela")

# NB: L'operazione di coercizione tra valori logici e numeric viene effettuata
# come segue:
as.numeric(TRUE)  # TRUE  ---------------> 1
as.numeric(FALSE) # FALSE ---------------> 0
as.logical(0)     # 0 ---------------> FALSE
as.logical(42)    # tutto il resto ---> TRUE
as.logical(1)     #                ---> TRUE

# Per questo motivo,
FALSE * TRUE + TRUE * 2 - FALSE * 10

# ESERCIZIO: Dato il seguente vettore
x <- c(FALSE, TRUE, log(1), 0)

# cosa vi aspettate che restituiscano i seguenti comandi? Perche'?
sum(x)
min(x)
prod(x + 1)

rm(list = ls())

# 7. Matrici --------------------------------------------------------------

# Le matrici possono essere viste come una generalizzazione dei vettori in due
# dimensioni. Come per i vettori, tutti gli elementi di una matrice devono
# essere dello tesso tipo (applicando le regole viste prima sulla coercizione
# tra elementi).

# Per creare una matrice posso usare la funzione matrix:
matrix(1:10)

# Di default, R crea una matrice con n righe ed 1 colonna (dove n e' il numero di
# elementi in input). Possiamo aggiustare questo aspetto usando gli argomenti
# nrow e ncol:
matrix(1:10, nrow = 5, ncol = 2)

# Nulla ci vieta di costruire una matrice di elementi di tipo logico:
matrix(c(TRUE, FALSE), nrow = 5, ncol = 2)

# NB: Il vettore in input (i.e. c(TRUE, FALSE)) e' stato duplicato fino a
# raggiungere la lunghezza richiesta (i.e. 5 * 2 = 10 elementi). Notiamo inoltre
# che, di default, la matrice viene "riempita" per colonna.

# o character:
matrix(letters[1:10], nrow = 5, ncol = 2, byrow = TRUE)

# La funzione dim() puo' essere usata per ricavare le dimensioni di una matrice:
(X <- matrix(1:9, 3, 3))
dim(X)

# Analogamente
nrow(X); ncol(X)

# L'operatore "[" puo' essere applicato anche alle matrici utilizzando una
# sintassi simile a quella dei vettori. Il seguente comando estrae l'elemento in
# prima riga e seconda colonna (iniziando a contare righe e colonne dalla
# posizione in alto a sx):
X[1, 2]

# oppure
X[1, ] # prima riga
X[c(1, 2), ] # prima e seconda riga
X[, c(2, 3)] # seconda e terza colonna

# Vediamo inoltre che, di default, il subset di un singolo elemento o di una
# singola riga/colonna restituisce un vettore e non piu' una matrice (lo si
# riconosce dal modo in cui gli oggetti vengono stampati a schermo). Il
# parametro "drop" serve a modificare questo comportamento:
X[1, 2, drop = FALSE]
X[1, , drop = FALSE]

# Le operazioni matematiche (vettorizzate) viste in precedenza sono 
# estendibili anche alle matrici. Ad esempio:
(X <- matrix(1:4, nrow = 2, ncol = 2))
(Y <- diag(2)) # matrice identita' di dimensione 2

X + Y # somma elemento per elemento
X + 1 # NB: il valore 1 e' implicitamente trasformato in una matrice avente 
      # dimensioni opportune.

X * Y # prodotto elemento per elemento
X * 2 # vedi sopra

# Analogamente,
X / (Y + 1)
log(X)
exp(X)
sin(X)
sign(Y)

# Tutte le operazioni elencate in questa parte dello script, vengono eseguite
# elemento per elemento.

# Il prodotto matriciale e' implementato tramite l'operatore %*%:
X %*% Y

# Il software R implementa anche diverse altre operazioni:
solve(X) # matrice inversa
t(X) # matrice trasposta
crossprod(X, Y) # prodotto incrociato: X'Y
solve(X, Y) # rapporto X^-1 Y
det(X) # determinante
eigen(X) # scomposizione in autovalori/autovettori
svd(X) # singular value decomposition
qr(X) # QR decomposition

# Le ultime 3 funzioni, i.e. eigen(), svd(), e qr() restituiscono in output una
# lista (vedi sotto...).

# APPROFONDIMENTO: Internamente R rappresenta le matrici come vettori a cui
# associa un "attributo" chiamato "dim" avente lunghezza 2. Purtroppo non
# possiamo entrare nel dettaglio di tali argomenti, ma vi invito a consultare le
# pagine di help associate (i.e. ?attributes) e le references del corso
# (
# https://cran.r-project.org/doc/manuals/r-release/R-intro.html#Getting-and-setting-attributes
# e
# https://cran.r-project.org/doc/manuals/r-release/R-intro.html#Arrays-and-matrices
# ).

# Di conseguenza, quando vogliamo fare un subset degli elementi di una
# matrice, e' sempre importante specificare correttamente gli indici rispetto a
# cui vogliamo fare subset: 

X
X[2] # il primo elemento nella rappresentazione di X
X[1, ] # la prima riga
X[, 1] # la prima colonna

rm(list = ls())

# 6. Subset-assignment ----------------------------------------------------

# Nelle lezioni precedenti abbiamo visto che l'operatore "[" puo' essere
# utilizzato per estrarre le componenti di un vettore. Ad esempio:
x <- 7:4
x[1]
x[c(1, 2)]
x[-3]

# La medesima operazione puo' essere compiuta utilizzando un vettore di valori
# logici:
x[c(TRUE, FALSE)] # subset + recycling

# Ripetendo gli indici, posso duplicare parti di un vettore:
x[c(1, 1, 1, 2, 2, 3)]

# Combinando gli operatori di subset (i.e. "[") e assignment (" <- ") possiamo
# sostituire parti di un vettore. Questa operazione viene tipicamente chiamata
# "subset-assignment":
x[1:2] <- c(10L, 9L)
x

# Quanto visto prima si applica anche in questo caso:
x[1] <- "A" # coercizione implicita di tutti gli elementi di un vettore
x

# Le stesse operazioni le applico anche alle matrici con alcuni accorgimenti:
X <- matrix(letters[1:9], 3, 3)
X
X[c(1, 2), c(2, 3)] <- "Z" # righe 1 e 2; colonne 2 e 3
X
X[1, 1] <- X[3, 3] <- "Q" # elementi (1, 1) e (3, 3)
X
