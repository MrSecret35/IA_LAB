ricerca(Cammino):-
    iniziale(S0),
    Soglia is 0,
    leggiGiaccio([],Ghiaccio),
    leggiGemme([],Gemme),

    martello(Martello),
    startMartello(S0,Cammino1,Soglia,Martello,Ghiaccio,GhiaccioFinale,Gemme,GemmeFinali),

    finale(Portale),
    startPortale(Martello,Cammino2,Soglia,Portale,GhiaccioFinale,_,GemmeFinali,GemmeFinaliFinali),

    posizioniContigue(GemmeFinaliFinali,GemmeFinaliFinali,N,0),
    N \== 0, 
    write("Gemme Contigue: "), write(N), write("\n"),
    
    tell('output.txt'),
    scriviCammino1(S0,Cammino1,Ghiaccio,_,Gemme,_),
    scriviCammino2(Martello,Cammino2,GhiaccioFinale,_,GemmeFinali,_),
    told,
    write(Cammino1), write("\n"), write(Cammino2), write("\n"),

    append(Cammino1,Cammino2,Cammino).



%--------------------------------------------------------
%--------------------Start Function----------------------
%--------------------------------------------------------

startMartello(S0,Cammino,Soglia,Ricerca,Ghiaccio,GhiaccioFinale,Gemme,GemmeFinali):-
    ric_prof_lim_martello(S0,Soglia,Cammino,[],StatoFinale,Ghiaccio,GhiaccioFinale,Gemme,GemmeFinali),
    Ricerca == StatoFinale.

startMartello(S0,Cammino,Soglia,Ricerca,Ghiaccio,GhiaccioFinaleN,Gemme,GemmeFinali):-
    ric_prof_lim_martello(S0,Soglia,_,[],StatoFinaleN,Ghiaccio,_,Gemme,_),
    Ricerca \== StatoFinaleN,
    SogliaN is Soglia+1,!,
    startMartello(S0,Cammino,SogliaN,Ricerca,Ghiaccio,GhiaccioFinaleN,Gemme,GemmeFinali).

startPortale(S0,Cammino,Soglia,Ricerca,Ghiaccio,GhiaccioFinale,Gemme,GemmeFinali):-
    ric_prof_lim_portale(S0,Soglia,Cammino,[],StatoFinale,Ghiaccio,GhiaccioFinale,Gemme,GemmeFinali),
    Ricerca == StatoFinale.

startPortale(S0,Cammino,Soglia,Ricerca,Ghiaccio,GhiaccioFinaleN,Gemme,GemmeFinali):-
    ric_prof_lim_portale(S0,Soglia,_,[],StatoFinaleN,Ghiaccio,_,Gemme,_),
    Ricerca \== StatoFinaleN,
    SogliaN is Soglia+1,!,
    startPortale(S0,Cammino,SogliaN,Ricerca,Ghiaccio,GhiaccioFinaleN,Gemme,GemmeFinali).

%--------------------------------------------------------
%-----------------ricerca in profondità------------------
%--------------------------------------------------------

ric_prof_lim_martello(S,0,[],_,S,G,G,GE,GE).

ric_prof_lim_martello(S,Soglia,[Az|ListaAzioni],ListaStatiVisitati,StatoFinale,Ghiaccio,GhiaccioFinale,Gemme,GemmeFinali):-
    Soglia>0,
    \+ finale(S),
    applicabileTutto(Az,[ S | Ghiaccio ],Gemme),
    trasformaMostro(Az,S,SNuovo,Ghiaccio,S,Gemme),
    trasformaGhiaccio(Az,Ghiaccio,GhiaccioN, Ghiaccio,Gemme,S),
    trasformaGhiaccio(Az,Gemme,GemmeN, Ghiaccio,Gemme,S),
    \+ member(SNuovo,ListaStatiVisitati),
    SogliaN is Soglia-1,

    ric_prof_lim_martello(SNuovo,SogliaN,ListaAzioni,[SNuovo|ListaStatiVisitati],StatoFinale,GhiaccioN,GhiaccioFinale,GemmeN,GemmeFinali).


ric_prof_lim_portale(S,0,[],_,S,G,G,GE,GE).

ric_prof_lim_portale(S,Soglia,[Az|ListaAzioni],ListaStatiVisitati,StatoFinale,Ghiaccio,GhiaccioFinale,Gemme,GemmeFinali):-
    Soglia>0,
    \+ finale(S),
    applicabileTuttoMartello(Az,S,Ghiaccio,Gemme),
    trasformaMostroConMartello(Az,S,SNuovo,Ghiaccio,S,GhiaccioNuovoDopoMostro,Gemme),
    trasformaGhiaccio(Az,GhiaccioNuovoDopoMostro,GhiaccioN,Ghiaccio,Gemme,S),
    trasformaGhiaccio(Az,Gemme,GemmeN, Ghiaccio,Gemme,S),
    \+ member(SNuovo,ListaStatiVisitati),
    SogliaN is Soglia-1,
    ric_prof_lim_portale(SNuovo,SogliaN,ListaAzioni,[SNuovo|ListaStatiVisitati],StatoFinale,GhiaccioN,GhiaccioFinale,GemmeN,GemmeFinali).


