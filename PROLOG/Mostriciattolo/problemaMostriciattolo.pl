% Dominio



%--------------------------------------------------------
%----------------------Trasforma-------------------------
%--------------------------------------------------------

trasformaMostro(Az,S,SNuovo,Ghiaccio,StatoP):-
    nApplicabili(Az,S,Ghiaccio,StatoP,N),
    trasformaN(Az,S,N,SNuovo).

trasformaGhiaccio(Az,[G | ListaG],[SNuovoGhiaccio| NewLista],Ghiaccio,StatoP):-
    nApplicabili(Az,G,Ghiaccio,StatoP,N),
    trasformaN(Az,G,N,SNuovoGhiaccio),
    trasformaGhiaccio(Az, ListaG, NewLista ,Ghiaccio,StatoP).

trasformaGhiaccio(_,[],[],_,_).



%--------------------------------------------------------
%--------------------N Applicabili-----------------------
%--------------------------------------------------------

nApplicabili(Az,S,Ghiaccio,StatoP,1+N):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+ member(SNuovo,Ghiaccio),
    %write(SNuovo),write("\n"),write(StatoP),write("\n"),write("\n"),write("\n"),
    SNuovo \== StatoP,
    nApplicabili(Az,SNuovo,Ghiaccio,StatoP,N).

nApplicabili(Az,S,Ghiaccio,StatoP,0+N):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    member(SNuovo,Ghiaccio),
    nApplicabili(Az,SNuovo,Ghiaccio,StatoP,N).

nApplicabili(Az,S,Ghiaccio,StatoP,0+N):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    SNuovo == StatoP,
    nApplicabili(Az,SNuovo,Ghiaccio,StatoP,N).

nApplicabili(Az,S,_,_,0):-
    \+ applicabile(Az,S).



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
    applicabileStato(Az,SNuovo,Ghiaccio).

applicabileStato(Az,S,Ghiaccio):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+ member(SNuovo,Ghiaccio).



%--------------------------------------------------------
%---------------------Trasforma N------------------------
%--------------------------------------------------------

trasformaN(est,pos(R,C),N,pos(R,CDestra)):-CDestra is C+N.
trasformaN(ovest,pos(R,C),N,pos(R,CSin)):-CSin is C-N.
trasformaN(nord,pos(R,C),N,pos(RSopra,C)):-RSopra is R-N.
trasformaN(sud,pos(R,C),N,pos(RSotto,C)):-RSotto is R+N.



%--------------------------------------------------------
%-------------------Leggi Ghiaccio-----------------------
%--------------------------------------------------------

leggiGiaccio(T,[G | Lista]):-
    ghiaccio(G),
    \+ member(G,T),
    leggiGiaccio([G|T], Lista).

leggiGiaccio(_,[]).