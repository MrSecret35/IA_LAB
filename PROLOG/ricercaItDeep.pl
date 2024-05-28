%wrapper
ricerca(Cammino,Soglia):-
    iniziale(S0),
    ric_prof_lim(S0,Soglia,Cammino,[],StatoFinale),
    finale(StatoFinale).

ricerca(Cammino,Soglia):-
    iniziale(S0),
    ric_prof_lim(S0,Soglia,_,[],StatoFinale),
    \+ finale(StatoFinale),
    SogliaN is Soglia+1,!,
    ricerca(Cammino,SogliaN).

%ricerca in profondità
ric_prof_lim(S,0,[],_,S).

ric_prof_lim(S,Soglia,[Az|ListaAzioni],ListaStatiVisitati,StatoFinale):-
    Soglia>0,
    \+ finale(S),
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+ member(SNuovo,ListaStatiVisitati),
    SogliaN is Soglia-1,
    ric_prof_lim(SNuovo,SogliaN,ListaAzioni,[SNuovo|ListaStatiVisitati],StatoFinale).