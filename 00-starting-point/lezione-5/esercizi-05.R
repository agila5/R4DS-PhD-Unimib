# 1. Provate a ripensare a quanto abbiamo detto riguardo il subset delle
# liste e delle matrici e provate a spiegare perchè i seguenti comandi
# restituiscono un vettore
iris$Sepal.Length
iris[["Sepal.Length"]]
# mentre 
iris[1]
# restituisce un dataframe ed invece
iris[1, 1]
# restituisce solo un numero. 

# --------------------------------------------------------------------------- #

# 2. Dopo aver importato il dataset small-flights.csv, si risponda alle seguenti
# domande:

# a) Quanti voli sono arrivati con almeno 1 ora di ritardo ? 
# b) Quanti voli sono atterrati a Houston (codice IAH o HOU) ? 
# c) Quanti voli sono partiti tra le 1AM e 6AM (estremi inclusi) ? 
# d) Quante osservazioni nel dataset hanno almeno una variabile che presenta un
# valore mancante?
# e) Quale volo ha percorso la maggior distanza? In quanto tempo? A che
# velocita' media andava?
# f) Aggiungete al dataset una nuova variabile che calcola il numero di minuti
# trascorsi dalla mezzanotte al momento del decollo di ogni volo. Ad esempio, se
# dep_time = 123 allora la nuova variabile deve essere pari a 1 * 60 + 23 = 83.
# g) E' sempre vero che air_time è uguale ad arr_time - dep_time? Perche? 
