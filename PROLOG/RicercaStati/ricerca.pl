
%wrapper
ricerca(Cammino):-
    iniziale(S0),
    ric_prof(S0,Cammino,[]).

%ricerca in profondità
%caso 0: siamo nello stato finale
ric_prof(S,[],_):-
    finale(S),!.

ric_prof(S,[Az|ListaAzioni],ListaStatiVisitati):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+ member(SNuovo,ListaStatiVisitati),
    ric_prof(SNuovo,ListaAzioni,[SNuovo|ListaStatiVisitati]).