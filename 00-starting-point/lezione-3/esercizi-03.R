# 1. Sia X una matrice 2 x 2 che contiene gli interi da 1 a 4. Dopo aver letto
# la pagina di help della funzione svd() (e.g. ?svd) e averne studiato l'output,
# si provi a ricostruire la matrice di input dati gli elementi contenuti nella
# lista in output.

# --------------------------------------------------------------------------- #

# 2. Gli NA in R tipicamente si propagano (nel senso che quasi tutte le
# operazioni i cui input includono NA restituiscono NA). Ad esempio:
x <- c(1, 2, NA)
mean(x)

# Provate a leggere la "help page" di ?mean per capire quale argomento e'
# possibile specificare per alterare questo comportamento.

# --------------------------------------------------------------------------- #

# 3. Provate a spiegare l'output delle seguenti operazioni:
TRUE | NA
NA & FALSE

# --------------------------------------------------------------------------- #

# 4. Dopo aver simulato un vettore x di n = 500 realizzazioni casuali estratte
# da una v.c. Gamma(1, 2) (CONTROLLATE BENE LA PARAMETRIZZAZIONE USATA DA R), si
# esegua il seguente comando
summary(x)
# e si commenti il risultato.

# --------------------------------------------------------------------------- #

# 5. Sia X ~ N(5, 5). Dopo aver consultato la pagina di help di ?qnorm e aver
# capito la "parametrizzazione" utilizzata da R, si calcoli il quantile di
# ordine 0.7 di X.

# --------------------------------------------------------------------------- #

# 6. Sia X ~ Poisson(1). Si simuli l'estrazione di n = 100 osservazioni da X e
# se ne calcoli la media ed il summary(). Dopo aver ripetuto questa operazioni
# diverse volte, cosa possiamo concludere?

# --------------------------------------------------------------------------- #

# 7. Dopo aver simulato un vettore x contenente n = 500 realizzazioni iid da una
# v.c. N(0, 1), si rappresenti l'istogramma dei valori ottenuti scegliendo un
# opportuno numero di bins.

# --------------------------------------------------------------------------- #

# 8. Si aggiunga al grafico precedente la funzione di densita' teorica (in
# rosso) e la sua stima non parametrica ottenuta tramite il comando density (in
# blu). Si commenti il risultato.