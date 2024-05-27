
%wrapper
ricerca(Cammino,Soglia):-
    iniziale(S0),
    ric_prof_lim(S0,Soglia,Cammino,[]).

%ricerca in profondità
%caso 0: siamo nello stato finale
ric_prof_lim(S,_,[],_):-
    finale(S),!.

ric_prof_lim(S,Soglia,[Az|ListaAzioni],ListaStatiVisitati):-
    Soglia>0,
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+ member(SNuovo,ListaStatiVisitati),
    SogliaN is Soglia-1,
    ric_prof_lim(SNuovo,SogliaN,ListaAzioni,[SNuovo|ListaStatiVisitati]).