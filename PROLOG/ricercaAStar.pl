%wrapper
ricerca(Cammino):-
    iniziale(S0),
    euristica(S0,H),
    ricercaAStar([(S0,0,H, [])], [], Cammino).

ricercaAStar([(S,_,_, Cammino)| _], _, Cammino):-
    finale(S),!.
/*
ric_prof_lim([(S,G,H, Cammino)| Open], Closed, Risultato):-
    azione applicabile
    nuovo stato SNuovo
    calcolo costo nuovo stato G*1 + New_H
    controllo se esiste nella lista closed
        se esiste controllo se il costo è minore 
            se minore lo riapro
    se non esiste -> Marcare come aperto SNuovo
    agigungo SNuovo agli stati aperti in ordine crescente
    aggiungo S alla lista dei Closed
    andiamo al prossimo stato minore 
*/

ricercaAStar([(S,G,H, Cammino)| Open], Closed, Risultato):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    euristica(SNuovo,Euristica),
    %CostoSNuovo is G+1+Euristica,
    \+ member(SNuovo,Closed),
    %aggiungi((Snuovo,G+1,Euristica,[Az|Cammino]), Open, ListaNuova),
    %ric_prof_lim(ListaNuova, [(S,G,H, Cammino)| Closed], Risultato).
    ric_prof_lim([(SNuovo,G+1,Euristica,[Az|Cammino]) | Open], [(S,G,H, Cammino)| Closed], Risultato).

ricercaAStar([(S,G,H, Cammino)| Open], Closed, Risultato):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    euristica(SNuovo,Euristica),
    CostoSNuovo is G+1+Euristica,
    member(SNuovo,Closed),
    restituisci(SNuovo,Closed,(SNuovo,GSNuovo,HSNUovo,_)),
    CostoSNuovoS is GSNuovo + HSNUovo,
    CostoSNuovo<CostoSNuovoS,
    %aggiungi((Snuovo,G+1,Euristica,[Az|Cammino]), Open, ListaNuova),
    %ric_prof_lim(ListaNuova, [(S,G,H, Cammino)| Closed], Risultato).
    ric_prof_lim([(SNuovo,G+1,Euristica,[Az|Cammino]) | Open], [(S,G,H, Cammino)| Closed], Risultato).

euristica(pos(X,Y),Ris):-
    finale(pos(X1,Y1)),
    X2 is abs(X-X1),
    Y2 is abs(Y-Y1),
    Ris is X2 + Y2 .

    
%aggiungi((S,G,H,C), Lista, ListaNuova):-



