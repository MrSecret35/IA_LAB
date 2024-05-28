ricerca(Cammino):-
    iniziale(S0),
    Soglia is 0,
    leggiGiaccio([],Ghiaccio),
    martello(Martello),
    start(S0,Cammino1,Soglia,Martello,Ghiaccio,GhiaccioFinale),
    write(Cammino1),
    write("\n"),
    write("Ho preso il martello"),
    finale(Portale),
    start(Martello,Cammino2,Soglia,Portale,GhiaccioFinale,_),
    write("\n"),
    write(Cammino2),
    append(Cammino1,Cammino2,Cammino).

start(S0,Cammino,Soglia,Ricerca,Ghiaccio,GhiaccioFinale):-
    ric_prof_lim(S0,Soglia,Cammino,[],StatoFinale,Ghiaccio,GhiaccioFinale),
    Ricerca == StatoFinale.

start(S0,Cammino,Soglia,Ricerca,Ghiaccio,GhiaccioFinale):-
    ric_prof_lim(S0,Soglia,_,[],StatoFinaleN,Ghiaccio,GhiaccioFinale),
    Ricerca \== StatoFinaleN,
    SogliaN is Soglia+1,!,
    start(S0,Cammino,SogliaN,Ricerca,Ghiaccio,GhiaccioFinale).


%--------------------------------------------------------
%-----------------ricerca in profondità------------------
%--------------------------------------------------------

ric_prof_lim(S,0,[],_,S,G,G).

ric_prof_lim(S,Soglia,[Az|ListaAzioni],ListaStatiVisitati,StatoFinale,Ghiaccio,GhiaccioFinale):-
    Soglia>0,
    \+ finale(S),
    applicabileTutto(Az,[ S | Ghiaccio ]),
    trasformaMostro(Az,S,SNuovo,Ghiaccio,GhiaccioN,Soglia),
    \+ member(SNuovo,ListaStatiVisitati),
    SogliaN is Soglia-1,
    ric_prof_lim(SNuovo,SogliaN,ListaAzioni,[SNuovo|ListaStatiVisitati],StatoFinale,GhiaccioN,GhiaccioFinale).



%--------------------------------------------------------
%-----------------------Dominio--------------------------
%--------------------------------------------------------


trasformaMostro(Az,S,SNuovo,Ghiaccio,GhiaccioN,Soglia):-
    Soglia>0,
    trasformaIT(Az,S,S1),
    trasformaTuttoGhiaccio(Az,Ghiaccio,Ghiaccio1),
    trasformaMostro(Az,S1,SNuovo,Ghiaccio1,GhiaccioN,Soglia-1).
    
trasformaMostro(Az,S,S,Ghiaccio,Ghiaccio,Soglia):-
    Soglia==0.

trasformaTuttoGhiaccio(Az,[G |Lista], GiacchioRes):-
    trasformaIT(Az,G,GNuovo),
    trasformaTuttoGhiaccio(Az,Lista,[GNuovo | GiacchioRes]).

trasformaTuttoGhiaccio(_, [], []).

trasformaIT(Az,G,GNuovo):-
    applicabile(Az,G),
    trasforma(Az,G,G1),
    trasformaIT(Az,G1,GNuovo).

trasformaIT(Az,G,G):-
    \+ applicabile(Az,G).

%--------------------------------------------------------
%--------------------Applicabile-------------------------
%--------------------------------------------------------
applicabileTutto(Az,[G | Lista]):-
    applicabileStato(Az,G,Lista).

applicabileTutto(Az,[G | Lista]):-
    \+ applicabileStato(Az,G,Lista),
    applicabileTutto(Az,Lista).

applicabileStato(Az,S,Ghiaccio):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    member(SNuovo,Ghiaccio),
    appicabileMostro(Az,SNuovo,Ghiaccio).

applicabileStato(Az,S,Ghiaccio):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+ member(SNuovo,Ghiaccio).


leggiGiaccio(T,[G | Lista]):-
    ghiaccio(G),
    \+ member(G,T),
    leggiGiaccio([G|T], Lista).

leggiGiaccio(_,[]).

