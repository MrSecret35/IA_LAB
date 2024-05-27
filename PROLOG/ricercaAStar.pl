%wrapper
ricerca(CamminoInvertito):-
    iniziale(S0),
    euristica(S0,H),
    ricercaAStar([(S0,0,H, [])], [], Cammino),
    inv(Cammino, CamminoInvertito).

ricercaAStar([(S,_,_, Cammino)| _], _, Cammino):-
    finale(S).

ricercaAStar([(S,G,H, Cammino)| Open], Closed, Risultato):-
    findall(Az, applicabile(Az,S),ElencoAz),
    elabora((S,G,H, Cammino), ElencoAz, Open, Closed, [(S_,G_,H_, Cammino_)| ListaNuovaOpen] ), !,
    ricercaAStar([(S_,G_,H_, Cammino_)| ListaNuovaOpen], [(S_,G_,H_, Cammino_) | [(S,G,H, Cammino)| Closed]], Risultato).

ricercaAStar([(S,G,H, Cammino)| Open], Closed, ["Finish"]):-
    Open == [],
    findall(Az, applicabile(Az,S),ElencoAz),
    elabora((S,G,H, Cammino), ElencoAz, Open, Closed, ListaNuovaOpen ),
    ListaNuovaOpen == [], !.

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
    member((SNuovo,_,_,_), Closed),
    restituisci(SNuovo,Closed,(SNuovo,G_,H_,C_)),
    CostoSNuovo_ is G_ + H_,
    CostoSNuovo =< CostoSNuovo_,
    C \== C_,
    aggiungi((SNuovo,G+1,HNuovo,[Az|C]), Open, ListaNuovaOpen),
    elabora((S,G,H,C), ElencoAz, ListaNuovaOpen, Closed, Res).

elabora((S,G,H,C), [Az| ElencoAz], Open, Closed, Res):-
    trasforma(Az,S,SNuovo),
    euristica(SNuovo,HNuovo),
    CostoSNuovo is G+1+HNuovo,
    member((SNuovo,_,_,_), Closed),
    restituisci(SNuovo,Closed,(SNuovo,G_,H_,_)),
    CostoSNuovo_ is G_ + H_,
    CostoSNuovo > CostoSNuovo_,
    elabora((S,G,H,C), ElencoAz, Open, Closed, Res).

elabora(_, [], Open, _, Open).

aggiungi((S,G,H,C), [(S_,G_,H_,C_)| Open], [(S,G,H,C)|[(S_,G_,H_,C_)|Open] ]):-
    Costo is G+H,
    Costo=<G_ + H_.

aggiungi((S,G,H,C), [], [(S,G,H,C)]).

aggiungi((S,G,H,C), [(S_,G_,H_,C_)| Open], [(S_,G_,H_,C_)| Lista]):-
    Costo is G+H,
    Costo>=G_ + H_,
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

% Inversione lista
invOpt([],Temp,Temp).

invOpt([Head|Tail],Temp,Res):-
    invOpt(Tail,[Head|Temp],Res).

inv(L,R):-invOpt(L,[],R).
    
%aggiungi((S,G,H,C), Lista, ListaNuova):-


firstElem([Head | _], Head).