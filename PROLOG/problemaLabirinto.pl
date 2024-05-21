/*
oggi vediamo come costruire piccole app di IA su prolog

Ricerca nello spazio degli stati

-Stato iniziale
-Insieme di azioni
-Stati obiettivi GOAL
-costo di ogni azione
*/


/*
Problema del labirinto

abbiamo un labirinto
e un robottino - che si muove nelle 4 direzioni

*/

applicabile(nord,pos(R,C)):-
    R >1,
    R1 is R-1,
    \+occupata(pos(R1,C)).

applicabile(sud,pos(R,C)) :-
    num_righe(NR), 
    R<NR,
    R1 is R+1,
    \+occupata(pos(R1,C)).

applicabile(est,pos(R,C)) :-
    num_colonne(NC), 
    C<NC,
    C1 is C+1,
    \+occupata(pos(R,C1)).

applicabile(ovest,pos(R,C)) :-
    C>1,
    C1 is C-1,
    \+occupata(pos(R,C1)).



%findall(Az, applicabile(Az,pos(2,3)),Elenco).
/*trovo tutte le azioni che posso fare da quella posizione*/

trasforma(est,pos(R,C),pos(R,CDestra)):-CDestra is C+1.
trasforma(ovest,pos(R,C),pos(R,CSin)):-CSin is C-1.
trasforma(nord,pos(R,C),pos(RSopra,C)):-RSopra is R-1.
trasforma(sud,pos(R,C),pos(RSotto,C)):-RSotto is R+1.
