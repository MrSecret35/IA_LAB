ricerca(Cammino):-
    
    iniziale(S0),
    Soglia is 0,
    leggiGiaccio([],Ghiaccio),
    leggiGemme([],Gemme),


    martello(Martello),
    startMartello(S0,Cammino1,Soglia,Martello,Ghiaccio,GhiaccioFinale,Gemme,GemmeFinali),

    finale(Portale),
    startPortale(Martello,Cammino2,Soglia,Portale,GhiaccioFinale,_,GemmeFinali,_),

    tell('output.txt'),
    scriviCammino1(S0,Cammino1,Ghiaccio,_,Gemme,_),
    scriviCammino2(Martello,Cammino2,GhiaccioFinale,_,GemmeFinali,_),
    told,
    write(Cammino1),write("\n"),write(Cammino2),write("\n"),

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



%--------------------------------------------------------
%-------------------------Output-------------------------
%--------------------------------------------------------

scriviCammino1(S,[Az|ListaAzioni],Ghiaccio,GhiaccioFinale,Gemme,GemmeFinali):-
    write("Posizione: "),write(S),write("\n"),
    write("Ghiaccio: "),write(Ghiaccio),write("\n"),
    write("Gemme: "),write(Gemme),write("\n"),
    write("\n"),

    trasformaMostro(Az,S,SNuovo,Ghiaccio,S,Gemme),
    trasformaGhiaccio(Az,Ghiaccio,GhiaccioN, Ghiaccio,Gemme,S),
    trasformaGhiaccio(Az,Gemme,GemmeN, Ghiaccio,Gemme,S),

    scriviCammino1(SNuovo,ListaAzioni,GhiaccioN,GhiaccioFinale,GemmeN,GemmeFinali).

scriviCammino1(S,[],Ghiaccio,Ghiaccio,Gemme,Gemme):-
    write("Posizione: "),write(S),write("\n"),
    write("Ghiaccio: "),write(Ghiaccio),write("\n"),
    write("Gemme: "),write(Gemme),write("\n"),
    write("\n").

scriviCammino2(S,[Az|ListaAzioni],Ghiaccio,GhiaccioFinale,Gemme,GemmeFinali):-
    write("Posizione: "),write(S),write("\n"),
    write("Ghiaccio: "),write(Ghiaccio),write("\n"),
    write("Gemme: "),write(Gemme),write("\n"),
    write("\n"),

    trasformaMostroConMartello(Az,S,SNuovo,Ghiaccio,S,GhiaccioNuovoDopoMostro,Gemme),
    trasformaGhiaccio(Az,GhiaccioNuovoDopoMostro,GhiaccioN, Ghiaccio,Gemme,S),
    trasformaGhiaccio(Az,Gemme,GemmeN, Ghiaccio,Gemme,S),

    scriviCammino2(SNuovo,ListaAzioni,GhiaccioN,GhiaccioFinale,GemmeN,GemmeFinali).

scriviCammino2(S,[],Ghiaccio,Ghiaccio,Gemme,Gemme):-
    write("Posizione: "),write(S),write("\n"),
    write("Ghiaccio: "),write(Ghiaccio),write("\n"),
    write("Gemme: "),write(Gemme),write("\n"),
    write("\n").