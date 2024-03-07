###########################################################################
################# Livellamento al Software R - Lezione 1 ##################
###########################################################################

# 1. R come calcolatrice --------------------------------------------------

# Possiamo utilizzare R come una calcolatrice:
1 + 1
6 * 7.1 # NB: il separatore decimale e' "." non ","
10 / 5 # Per la divisione, usiamo l'operatore /
3 ^ 2 # o, equivalentemente, 3 ** 2

# NB: Tutto cio' che viene riportato in uno script R dopo il simbolo "#"
# (incluso) viene considerato da R come un "commento" e non viene eseguito. I
# commenti servono a descrivere il comportamento di un blocco di codice.

# Quale pensate che sia il risultato della seguente operazione?
1 + 1 / 2

# Le operazioni matematiche possono essere concatenate sfruttando la
# "precedenza" degli operatori (?Syntax) oppure definendo esplicitamente
# l'ordine tramite parentesi tonde:
(1 + 1) / 2

# Le funzioni matematiche piu' comuni sono gia' implementate nel linguaggio:
exp(1)
log(2)
sin(0); cos(pi)
sin(0) cos(pi) # errore di sintassi

# NB1: Il simbolo ";" serve a concatenare due espressioni sulla stessa riga
# NB2: Il linguaggio R e' detto "case sensitive" (nel senso che distingue tra
# lettere maiuscole e minuscole). Di conseguenza, la seguente operazione
# restituisce un errore
SIN(pi)

# poiche' la funzione SIN non esiste (mentre, come abbiamo gia' visto, esiste la
# funzione sin).

# 2. Chiedere aiuto -------------------------------------------------------

# A questo punto potremmo domandarci: ma, quando eseguiamo il seguente codice, 
log(1)

# in che base e' calcolato il logaritmo? Base 10? Base e? Per rispondere a
# questa domanda dobbiamo consultare la "help page" della funzione "log" e, per
# farlo esistono due modi:
?log

# oppure
help(log)

# In entrambi i casi, consultando la sezione denominata "Description" o "Usage"
# vediamo che, di default, il logaritmo e' calcolato in base exp(1) (cioe' in base
# e).

# Nel caso volessimo cercare aiuto per una funzione di cui non ricordiamo
# precisamente il nome ma solo una generica descrizione possiamo fare come
# segue:
help.search("Wilcox")

# oppure
??Wilcox

# NB:
?Wilcox
??Wilcox
???Wilcox
????Wilcox # :) 

# Il seguente comando apre una sessione interattiva (nel browser o nella Viewer
# Table) tramite la quale possiamo consultare diversi manuali di R, FAQ, guide,
# technical papers, NEWS file e cosi' via.
help.start()

# 3. Assegnazione --------------------------------------------------------

# Tutti i comandi visti nelle sezioni 1 e 2 calcolano un valore (e.g. exp(3)) e
# lo stampano a schermo. Dopo di che, questo valore e' perso. Se volessimo
# conservare questo valore per utilizzarlo in seguito, dovremmo assegnarlo ad
# una variabile tramite l'operatore " <- " (o, equivalentemente, " = "). Ad
# esempio:
y <- 0
x = 2 + 2

# Se controlliamo il "Global Environment" (scheda in alto a dx della
# configurazione di default di Rstudio) vediamo che dopo aver eseguito i comandi
# precedenti sono state create due variabili chiamate "x" ed "y". Ad "y" e'
# assegnato il valore 0 mentre ad "x" e' assegnato il valore restituito
# dall'operazione "2 + 2".

# Possiamo sempre richiamare queste due variabili tramite il loro nome: 
x

# ed utilizzarle per diverse operazioni, e.g. 
x ^ y

# Per elencare tutte le variabili salvate in memoria possiamo usare il seguente
# comando:
ls()

# Per cancellare una variabile (quando non ci serve piu'):
rm("x")

# Per cancellarle tutte:
rm(list = ls())

# Per RIAVVIARE R da Rstudio, potete utilizzare 
# la combinazione di comandi CTRL + SHIFT + F10. 

# NB: Cosa succede se (volontariamente o meno) non completiamo la sintassi di un
# comando? Ad esempio, cosa succede se seleziono e provo ad eseguire la seguente
# riga di codice:

# x <- 2 +

# NB2: Come succede se eseguiamo il codice precedente senza evidenziare
# unicamente la sintassi rilevante?

# NB3: L'insieme di caratteri che puo' essere usato per specificare il nome di
# una variabile dipende da alcune caratteristiche del PC (i.e. ?locales). Io vi
# suggerire di utilizzare unicamente le lettere da A a Z (maiuscole o
# minuscole), i numeri da 0 a 9, ed i caratteri "-", "_" e ".". Il nome di una
# variabile non puo' cominciare con un numero (e.g. 2x <- 1 non e' un comando
# valido).

# NB4: Il linguaggio R e' case sensitive. Di conseguenza, il seguente codice
# restituisce errore.
x <- 1
X

rm(x)

# 4. Le funzioni in R -----------------------------------------------------

# NB: Quanto segue e' solo una piccola introduzione al concetto di "funzione" in
# R. Nelle prossime lezioni vedremo piu' dettagli ed impareremo a definire nuove
# funzioni.

# Come abbiamo appena visto, diverse funzioni matematiche (e.g. exp, log, help)
# sono implementate di default nel software.

# Per eseguire una funzione, e' necessario scriverne il nome includendo eventuali
# argomenti aggiuntivi tra parentesi. Ad esempio:
log(4)

# NB: Cosa succede se non includo le parentesi tonde?
log

# Questo invece da errore
log 4

# Dalla help page (i.e. ?log) possiamo leggere quali sono gli argomenti
# accettati dalla funzione ed il loro ordine. In questo caso, la funzione "log"
# ammette due argomenti chiamati "x" e "base". Dalla sezione "Arguments"
# possiamo leggere che "x" rappresenta il valore rispetto a cui vogliamo
# calcolare il logaritmo e "base" la base. L'argomento "base" ha un valore di
# default pari a exp(1). Di conseguenza,
log(4)

# calcola il logaritmo di 4 in base e. Per cambiare la base possiamo scrivere
log(4, 2)

# o, equivalentemente,
log(4, base = 2)
log(base = 2, 4)
log(base = 2, x = 4)

# NB: Gli argomenti di una funzione in R possono essere specificati "by
# position" o "by name". "by position" vuol dire che i valori definiti entro le
# parentesi tonde vengono passati alla funzione seguendo lo stesso ordine con
# cui sono stati specificati. Ad esempio
log(4, 2)

# chiede di calcolare il logaritmo di 4 in base 2. D'altro canto, "by name" vuol
# dire che i valori passati entro le parentesi tonde vengono definiti
# specificando l'argomento a cui devono essere assegnati. Ad esempio:
log(base = 2, x = 4)

# o, equivalentemente,
log(x = 4, base = 2)

# NB: E' possibile anche mischiare i due stili.
log(4, base = 2)

# In questo caso, i valori specificati "by position" vengono assegnati seguendo
# lo stesso ordine degli argomenti della funzione saltando gli argomenti
# specificati "by name".

# Le funzioni e gli operatori possono essere anche concatenate, ad esempio:
log(exp(3))

# oppure
sqrt(3 ^ 2)

# In questo caso, le operazioni piu' "interne" vengono eseguite per prime.

# 5. I vettori in R -------------------------------------------------------

# Uno degli oggetti piu' comuni con cui avrete a che fare quando lavorate con R
# sono i "vettori": sequenze di valori aventi lo stesso "tipo".

# Per creare un vettore si utilizza la funzione "c()", ad esempio:
(x <- c(4, 5, 6))

# crea un vettore denominato x di tipo numeric. 

# L'operatore "[..]" puo' essere utilizzato per estrarre parti di un vettore
# specificando uno o piu' indici di tipo numerico. Ad esempio:
x[1]

# restituisce il primo elemento del vettore mentre
x[c(1, 3)]
x[1, 3] # non funziona

# restituisce il primo ed il terzo elemento.

# NB: In R, gli indici di un vettore vengono definiti partendo dal valore 1.
# x[0] restituisce un vettore di lunghezza nulla avente lo stesso tipo di x.
# Provate!

# E' possibile anche rimuovere parti di un vettore utilizzando indici negativi:
x[-1]

# NB: In R non esiste il concetto di "scalare", quindi anche un singolo valore
# (e.g. 3) e' un vettore di lunghezza 1.

# La lunghezza di un vettore puo' essere determinata usando la funzione "length()":
length(x)
length(4) # un singolo numero e' un vettore di tipo double con lunghezza 1

# 6. Le tipologie di vettori ----------------------------------------------

# In R esistono 6 tipologie: "logical", "integer", "double", "complex",
# "character", "raw". Le classi "complex" e "raw" sono molto piu' rare delle
# altre (almeno nell'analisi statistica) e, per semplicita', presenteremo
# solamente i 4 tipi piu comuni.

# > 5.1 Logical  -----------------------------------------------------------

# I vettori di tipo "logical" sono il risultato di un test il cui esito puo'
# essere solamente "vero" (TRUE) oppure "falso" (FALSE). Ad esempio:

4 < 56
z <- c(TRUE, FALSE)
z2 <- FALSE

# L'operatore "<" serve a testare se la quantita' a sx e' minore della
# quantita' a dx. Analogamente

x >= 5

# NB: Nel codice precedente l'operatore >= viene applicato "elemento per
# elemento" (nel senso che il risultato dell'operazione x >= 5 e' un vettore il
# cui elemento i-esimo e' il risultato del test x[i] >= 5). Secondo il linguaggio
# R, questo significa che l'operazione ">=" e' una operazione "vettorizzata" e
# vedremo meglio il significato di questa operazione nella lezione 2.

# Possiamo definire un vettore di valori logici come segue:
p <- c(TRUE, FALSE, TRUE)

# L'operatore "!" serve a negare un'operazione logica o un vettore di valori
# logici:
!TRUE
!p

# L'operatore "[" accetta anche indici specificati tramite vettori di tipo
# booleano e restituisce solo quegli elementi di x che corrispondono ad indici
# TRUE:
x[p]

# Le operazioni precedenti possono essere concatenate, per cui
x[x >= 5]

# seleziona unicamente gli elementi di x maggiori o uguali a 5.

# NB: Anche gli operatori ! e [  funzionano in maniera vettorizzata, cioè
# lavorano "elemento per elemento".

# Dato un vettore, posso testare se e' di tipo "logical" tramite "is.logical()":
is.logical(p)
is.logical(x)
is.logical(p, x)

# Gli operatori "&" (AND) e "|" (OR) possono essere usati per concatenare test
# logici. Ad esempio:
TRUE & FALSE
(TRUE | FALSE) & FALSE
c(TRUE, FALSE) | c(FALSE, FALSE) # l'operazione viene eseguita "pairwise", vedi lezione 2. 

# Le funzioni "all()" ed "any()" possono essere usate per determinare se:
# 1) tutti gli elementi di un vettore logico sono pari a TRUE;
# 2) almeno uno degli elementi e' pari a TRUE.
all(p)
any(p)
all(x >= 4)
all(x >= 6)
any(x >= 6)
any(x >= 7)

# Puliamo il nostro working space (ovvero il Global Environment)
rm(list = ls())

# > 5.2 Integer and double ---------------------------------------------------

# R utilizza due classi distinte per rappresentare i valori numerici: "integer"
# e "double".

# Per creare un vettore di tipo "integer" dobbiamo utilizzare il suffisso "L",
# ad esempio:
c(1L, 2L)

# mentre
c(4, 7)

# indica un vettore di tipo "double".

# Tipicamente, il tipo "integer" viene utilizzato da R quando il software si
# deve interfacciare con altri linguaggi (e.g. C, Fortran) dove la differenza
# tra tipi "int" e "double" e' rilevante. La differenza tra "integer" e "double"
# non e' cosi' importante per i nostro scopi. Inoltre, la classe integer e'
# molto meno comune del tipo "double", percui non ci soffermeremo troppo su
# questa distinzione.

# Esistono tuttavia alcune eccezioni. Per esempio, l'operatore ":" (utilizzato
# con una sintassi tipo a:b) puo' essere utilizzato per creare una sequenza di
# numeri interi che va da "a" a "b":
1:5

# oppure
n <- 10
1:n

# La stessa operazione (e molte altre piu' articolate, controllate gli esempi
# nella help page) possono essere eseguite usando la funzione seq():
seq(1, n)
seq(1, n, by = 2)
seq(1, n, length.out = 5) # non restituisce sempre una sequenza di interi...

# Dato un vettore di tipo double possiamo calcolare diverse quantita' anche
# concatenando funzioni diverse:
x <- c(-3, exp(1), pi, 0)

abs(x) # valore assoluto
floor(x) # arrotonda all'intero piu' piccolo
sign(x) # segno (-1 = negativo, 0 = 0, 1 = positivo)
sum(x) # somma
mean(x) # media arimetica
sd(x) # deviazione standard (dividendo per n - 1)
median(x) # mediana (check ?median for more details)
prod(x) # prodotto
cumsum(x) # somma cumulata
min(x); max(x) # min e max
range(x) # come sopra ma in un unico vettore
head(x, 2); tail(x, 2) # i primi e gli ultimi 2 elementi di un vettore

# Come possiamo notare, alcune di queste funzioni sono vettorizzate in maniera "nativa". 
