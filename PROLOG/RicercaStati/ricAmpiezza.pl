
%wrapper
ricerca(Cammino):-
    iniziale(S0),
    ric_ampiezza([[S0,[]]],[],Cammino).

ric_ampiezza([[S,Cammino]|_],_,Cammino):-
    finale(S),!.

ric_ampiezza([[S,Cammino]|Tail],Visitati,Risultato):-
    \+member(S,Visitati),!,
    findall(Az,applicabile(Az,S),ListaAzioni),
    generaNuoviStati([S,Cammino],ListaAzioni,ListaNuoviStati),
    diffInsi(ListaNuoviStati,Tail,ListaStatiDaAggiungere),
    append(Tail,ListaStatiDaAggiungere,NuovaTail),
    ric_ampiezza(NuovaTail,[S|Visitati],Risultato).

ric_ampiezza([_|Tail],Visitati,Risultato):-
    %member(S,Visitati),
    ric_ampiezza(Tail,Visitati,Risultato).

%TO DO - generaNuoviStati(Stato,Azioni,NuoviStati):-
generaNuoviStati(_,[],[]).
generaNuoviStati([S,Cammino],[Az|T],
    [[SNuovo,[Az|Cammino]]|NuoviStati] ):-
    trasforma(Az,S,SNuovo),
    generaNuoviStati([S,Cammino],T,NuoviStati).


%diffInsi(Lista1,Lista2,Res):- %to Do
diffInsi([],_,[]).
diffInsi([[S,_]|Tail],B,Res):-
    member([S,_],B),!,
    diffInsi(Tail,B,Res).

diffInsi([[S,Cammino]|Tail],B, [[S,Cammino]|ResTail]):-
    diffInsi(Tail,B,ResTail).
