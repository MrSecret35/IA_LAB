ricerca(Cammino):-
    iniziale(S0),
    Soglia is 0,
    leggiGiaccio([],Ghiaccio),
    martello(Martello),
    % write("Giaccio: "),write(Ghiaccio),write("\n"),
    startMartello(S0,Cammino1,Soglia,Martello,Ghiaccio,GhiaccioFinale),
    write("Giaccio finale: "),write(GhiaccioFinale),write("\n"),
    %write("Ho preso il martello"),write("\n"),
    finale(Portale),
    startPortale(Martello,Cammino2,Soglia,Portale,GhiaccioFinale,GhiaccioFinaleFinale),
    %write("Giaccio finale finale: "),write(GhiaccioFinaleFinale),write("\n"),
    write(Cammino1),write("\n"),
    write(Cammino2),write("\n"),
    append(Cammino1,Cammino2,Cammino).

%--------------------------------------------------------
%--------------------Start Function----------------------
%--------------------------------------------------------

startMartello(S0,Cammino,Soglia,Ricerca,Ghiaccio,GhiaccioFinale):-
    ric_prof_lim(S0,Soglia,Cammino,[],StatoFinale,Ghiaccio,GhiaccioFinale),
    Ricerca == StatoFinale.

startMartello(S0,Cammino,Soglia,Ricerca,Ghiaccio,GhiaccioFinaleN):-
    ric_prof_lim(S0,Soglia,_,[],StatoFinaleN,Ghiaccio,_),
    Ricerca \== StatoFinaleN,
    SogliaN is Soglia+1,!,
    startMartello(S0,Cammino,SogliaN,Ricerca,Ghiaccio,GhiaccioFinaleN).

startPortale(S0,Cammino,Soglia,Ricerca,Ghiaccio,GhiaccioFinale):-
    ric_prof_lim(S0,Soglia,Cammino,[],StatoFinale,Ghiaccio,GhiaccioFinale),
    Ricerca == StatoFinale.

startPortale(S0,Cammino,Soglia,Ricerca,Ghiaccio,GhiaccioFinaleN):-
    ric_prof_lim(S0,Soglia,_,[],StatoFinaleN,Ghiaccio,_),
    Ricerca \== StatoFinaleN,
    SogliaN is Soglia+1,!,
    startPortale(S0,Cammino,SogliaN,Ricerca,Ghiaccio,GhiaccioFinaleN).

%--------------------------------------------------------
%-----------------ricerca in profondità------------------
%--------------------------------------------------------

ric_prof_lim(S,0,[],_,S,G,G).

ric_prof_lim(S,Soglia,[Az|ListaAzioni],ListaStatiVisitati,StatoFinale,Ghiaccio,GhiaccioFinale):-
    Soglia>0,
    \+ finale(S),
    applicabileTutto(Az,[ S | Ghiaccio ]),
    trasformaMostro(Az,S,SNuovo,Ghiaccio,S),
    trasformaGhiaccio(Az,Ghiaccio,GhiaccioN, Ghiaccio,S),
    \+ member(SNuovo,ListaStatiVisitati),
    SogliaN is Soglia-1,
    ric_prof_lim(SNuovo,SogliaN,ListaAzioni,[SNuovo|ListaStatiVisitati],StatoFinale,GhiaccioN,GhiaccioFinale).

