# 1. Dopo aver definito un vettore x che contiene gli esiti ottenuti per n = 6
# esami diversi, si provi a calcolarne la varianza eseguendo tutti gli step a 
# mano uno dopo l'altro e salvando il risultato in variabili intermedie.  

# NB: Esistono diversi metodi per calcolare la varianza di un vettore x di n
# elementi: https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance. 
# Provate ad implementare almeno due algoritmi diversi. 

# --------------------------------------------------------------------------- #

# 2. Leggete la pagina di help della funzione reprex() nel pacchetto R "reprex"
# e provate ad eseguire i relativi esempi.

# --------------------------------------------------------------------------- #

# 3. Dopo aver letto la help page relativa alla funzione startsWith(),
# provate a
# A) Definire un vettore chiamato z "incollando" i vettori x ed y (definiti come
# riportato nella sezione 4 dello script 2);
# B) Selezionare unicamente quegli elementi di z che
#    * cominciano per "r"
#    * finiscono per "o".

# NB1: Devono essere soddisfatte entrambe le condizioni.
# NB2: Come gia' visto durante la scorsa lezione, l'operatore "[" puo' essere
# utilizzato per selezionare solamente alcuni elementi di un vettore.

# --------------------------------------------------------------------------- #

# 4. Dopo aver letto la pagina di help della funzione chartr() ed aver
# testato qualcuno dei suoi esempi, provate a scrivere una espressione R per
# convertire la stringa "ABBCDD" in "AbbCDD"

# --------------------------------------------------------------------------- #

# 5. Il linguaggio R definisce due costanti chiamate LETTERS e letters che
# contengono tutte le lettere dell'alfabeto in maiuscolo e minuscolo:
LETTERS

# Come faccio a concatenare a coppia le prime dieci lettere maiuscole e
# minuscole?

# --------------------------------------------------------------------------- #

# 6. La funzione table() serve a generare una tabella di frequenze
# assolute per un dato vettore in input. Ad esempio:
table(c("A", "B", "B"))

# Dato il seguente vettore
x <- c("Jan", "Jan", "Dec", "Mar")

# a) Si calcoli la tabella di frequenze assolute di x;
# b) Si definisca una nuova variabile chiamata z corrispondente alla
# rappresentazione factor di x, specificando che l'argomento levels deve essere
# pari a month.abb;
# c) Si calcoli la tabella di frequenze assolute di z. Che differenza c'e' tra i
# due output mostrati in precedenza? E perche' questo potrebbe essere importante?
# d) Dato il seguente vettore
y <- c("Mar", "May", "Jun", "Jul")

# si calcoli la tabella a doppia entrata che rappresenta le frequenze assolute
# congiunte delle due osservazioni (i.e. table(x, y)) e si commenti il
# risultato.

# APPROFONDIMENTO: La funzione marginSums() puo' essere utilizzata per calcolare
# delle frequenze marginali data una tabella di contingenza bivariata.

# e) Cosa cambia se x ed y vengono specificati come factors i cui livelli sono
# pari a month.abb?

# f) Come pensate si possa calcolare la matrice delle frequenze relative nel
# caso univariato?

# g) La funzione cut() (?cut) serve per dividere una variabile numerica x in
# livelli (i.e. un factor) dato un secondo vettore che rappresenta i "breaks".
# Dopo aver definito un vettore x che contiene gli interi da 1 a 10, lo si
# divida in due classi a piacere e se ne calcoli la tabella di frequenze.

# --------------------------------------------------------------------------- #

# 7. Si risolvano i seguenti problemi. 

# A) Si crei una matrice A contenente gli interi da 10 a 24 avente 5 righe, 3
# colonne e valori inseriti per colonna.
# B) Si calcoli la somma per riga e per colonna di A (i.e. ?rowSums).
# C) Si calcoli la trasposta di A.
# D) Si definisca una nuova matrice B di dimensioni opportune per calcolare il
# prodotto AB (e si calcoli tale prodotto).
