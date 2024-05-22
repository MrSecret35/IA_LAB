%wrapper
ricerca(Cammino):-
    iniziale(S0),
    euristica(S0,H),
    ricercaAStar([(S0,0,H, [])], [], Cammino).

ricercaAStar([(S,_,_, Cammino)| _], _, Cammino):-
    finale(S).

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

/*
ricercaAStar([(S,G,H, Cammino)| Open], Closed, Risultato):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    euristica(SNuovo,HNuovo),
    %CostoSNuovo is G+1+HNuovo,
    \+ member(SNuovo,Closed),
    %aggiungi((Snuovo,G+1,HNuovo,[Az|Cammino]), Open, ListaNuova),
    %ric_prof_lim(ListaNuova, [(S,G,H, Cammino)| Closed], Risultato).
    ricercaAStar([(SNuovo,G+1,HNuovo,[Az|Cammino]) | Open], [(S,G,H, Cammino)| Closed], Risultato).

ricercaAStar([(S,G,H, Cammino)| Open], Closed, Risultato):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    euristica(SNuovo,HNuovo),
    CostoSNuovo is G+1+HNuovo,
    member(SNuovo,Closed),
    restituisci(SNuovo,Closed,(SNuovo,GSNuovo,HSNUovo,_)),
    CostoSNuovoS is GSNuovo + HSNUovo,
    CostoSNuovo<CostoSNuovoS,
    %aggiungi((Snuovo,G+1,HNuovo,[Az|Cammino]), Open, ListaNuova),
    %ric_prof_lim(ListaNuova, [(S,G,H, Cammino)| Closed], Risultato).
    ricercaAStar([(SNuovo,G+1,HNuovo,[Az|Cammino]) | Open], [(S,G,H, Cammino)| Closed], Risultato).
*/


ricercaAStar([(S,G,H, Cammino)| Open], Closed, Risultato):-
    findall(Az, applicabile(Az,S),ElencoAz),
    elabora((S,G,H, Cammino), ElencoAz, Open, Closed, ListaNuovaOpen),
    ricercaAStar(ListaNuovaOpen, [(S,G,H, Cammino)| Closed], Risultato).


elabora((S,G,H,C), [Az| ElencoAz], Open, Closed, Res):-
    trasforma(Az,S,SNuovo),
    euristica(SNuovo,HNuovo),
    \+ member((SNuovo,_,_,_), Closed),
    aggiungi((SNuovo,G+1,HNuovo,[Az|C]), Open, ListaNuovaOpen),
    elabora((S,G,H,C), ElencoAz, ListaNuovaOpen, Closed, Res).

elabora((S,G,H,C), [Az| ElencoAz], Open, Closed, Res):-
    trasforma(Az,S,SNuovo),
    euristica(SNuovo,HNuovo),
    CostoSNuovo is G+1+HNuovo,
    member((SNuovo,_,_, _), Closed),
    restituisci(SNuovo,Closed,(SNuovo,G_,H_,_)),
    CostoSNuovo_ is G_ + H_,
    CostoSNuovo < CostoSNuovo_,
    aggiungi((SNuovo,G+1,HNuovo,[Az|C]), Open, ListaNuovaOpen),
    elabora((S,G,H,C), ElencoAz, ListaNuovaOpen, Closed, Res).

elabora((S,G,H,C), [Az| ElencoAz], Open, Closed, Res):-
    trasforma(Az,S,SNuovo),
    euristica(SNuovo,HNuovo),
    CostoSNuovo is G+1+HNuovo,
    member((SNuovo,_,_, _), Closed),
    restituisci(SNuovo,Closed,(SNuovo,G_,H_,_)),
    CostoSNuovo_ is G_ + H_,
    CostoSNuovo >= CostoSNuovo_,
    elabora((S,G,H,C), ElencoAz, Open, Closed, Res).

elabora(_, [], Open, _, Open).

aggiungi((S,G,H,C), [(S_,G_,H_,C_)| Open], [(S,G,H,C)|[(S_,G_,H_,C_)|Open] ]):-
    Costo is G+H,
    Costo=<G_ + H_.

aggiungi((S,G,H,C), [], [(S,G,H,C)]).

aggiungi((S,G,H,C), [(S_,G_,H_,C_)| Open], [(S_,G_,H_,C_)| Lista]):-
    Costo is G+H,
    Costo>G_ + H_,
    aggiungi((S,G,H,C), Open, Lista).

%Dato uno stato e una lista Restituisci i valori corrispondenti a quello stato
restituisci(S,[(S,G,H,C)| _],(S,G,H,C)).

restituisci(S,[(SX,_,_,_)| Closed],(S,G,H,C)):-
    S \== SX, 
    restituisci(S, Closed, (S,G,H,C)).


euristica(pos(X,Y),Ris):-
    finale(pos(X1,Y1)),
    X2 is abs(X-X1),
    Y2 is abs(Y-Y1),
    Ris is X2 + Y2 .

    
%aggiungi((S,G,H,C), Lista, ListaNuova):-



