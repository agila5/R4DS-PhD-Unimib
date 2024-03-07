# 1. Provate a definire una funzione f la quale, dato un vettore numerico in
# input, restituisce una lista contenente la media, la varianza, il minimo ed il
# massimo di tale vettore. Assegnate un nome opportuno agli elementi della
# lista e testatela con un input opportuno.

# --------------------------------------------------------------------------- #

# 2. Supponiamo che X ~ Poisson(lambda). Si implementi una funzione che, dati in
# input un vettore numerico x di lunghezza n estratto da n ed una stima per
# lambda, restituisce il valore della funzione di verosimiglianza in quel punto.

# --------------------------------------------------------------------------- #

# 3. Dato il seguente campione casuale,
set.seed(1)
x <- rpois(n = 100, lambda = 2)
# si rappresenti la funzione di verosimiglianza fissando un opportuno range di
# valori per lambda. Suggerimento: consultare l'help della funzione "curve()"
# per capire come rappresentare funzioni definite ad-hoc.

# --------------------------------------------------------------------------- #

# 4. Supponiamo che X1, ..., X100 sia un campione casuale estratto da
# una popolazione X ~ N(mu, 1). Si implementi una funzione che, dato in input un
# valore mu0, permetta di calcolare il pvalue del test
#                        H0: mu = mu0 vs H1: mu > mu0.

# --------------------------------------------------------------------------- #

# 5. La congettura di Collatz afferma che, dato un qualsiasi numero
# naturale n, applicando il seguente algoritmo:
# a) se n e' pari lo divido per 2;
# b) se n e' dispari lo moltiplico per 3 ed aggiungo 1;
# allora la successione di elementi termina sempre raggiungendo il numero 1.

# Si implementi una funzione che, dato in input un numero naturale n di
# lunghezza 1, restituisce il successivo secondo l'algoritmo definito della
# congettura di Collatz. Ad esempio, my_collatz(4) deve restituire 2,
# my_collatz(5) deve restituire 16 e cosi' via.

# Suggerimento: Controllate ?"Arithmetic" per capire quale operatore puo' essere
# usato per determinare se un numero n e' pari a dispari.

# --------------------------------------------------------------------------- #

# 6. Una variabile casuale X segue una distribuzione "triangolare"
# (https://en.wikipedia.org/wiki/Triangular_distribution) di parametri
# a <= b <= c se la sua funzione di densita' e' esprimibile nel seguente modo:
# f(x) =
# 0 se x < a;
# 2(x - a) / ((b - a)(c - a)) se a <= x < c
# 2 / (b - a)  se x = c
# 2(b - x) / ((b - a)(b - c)) se c < x <= b
# 0 se b < x

# Si implementi una funzione del tipo dtriangular(x, a, b, c) che permette di
# calcolare tale fdd dato un set di valori per a, b, e c scelto da voi. Si
# implementi anche un insieme di test per verificare la ragionevolezza dei
# valori passati ad a, b, e c.

# --------------------------------------------------------------------------- #

# 7. Provate ad implementare un ciclo for che stampa a schermo le lyrics della
# famosa canzone "99 bottles of beer on the wall": http://www.99-bottles-of-beer.net/

# --------------------------------------------------------------------------- #

# 8. Provate ad implementare il celebre algoritmo "fizzbuzz". Tale algoritmo
# chiede di ciclare su un vettore numerico in input (i.e. x = 1:100) applicando
# le seguenti condizioni:
# - se l'input in posizione i di x e' multiplo di 3, si stampi la stringa "fizz";
# - se l'input in posizione i di x e' multiplo di 5, si stampi la stringa "buzz";
# - se l'input in posizione i di x e' multiplo di 3 e 5, si stampi la stringa "fizzbuzz";
# - altrimenti, si stampi il valore di x[i].

# --------------------------------------------------------------------------- #

# 9. Provate a (ri)creare una rappresentazione grafica per mostrare l'andamento
# di un processo di Weiner. Ripetete la simulazione diverse volte per vedere
# diverse realizzazioni di tale processo variando anche i valori di sigma2 ed il
# numero di iterazioni.

# --------------------------------------------------------------------------- #

# 10. Provate a sviluppare due funzioni (e.g. f1 ed f2) che implementano i due
# approcci mostrati a lezione per la simulazione di un processo di Weiner ed a
# confrontarne i tempi di esecuzione (?system.time) per un diverso numero di
# iterazioni.

# --------------------------------------------------------------------------- #

# 11. Provate a sviluppare una funzione (e.g. my_collatz_sequence) che, dato in
# input un numero naturale n, restituisce in output un vettore contenente la
# sequenza completa dei valori restituiti dall'algoritmo di Colltaz fino a
# raggiungere 1. Ad esempio, my_collatz_sequence(5) deve restituire il vettore
# composto dagli elementi c(5, 16, 8, 4, 2, 1).