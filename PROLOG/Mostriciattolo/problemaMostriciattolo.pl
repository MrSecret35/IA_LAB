% Dominio



%--------------------------------------------------------
%----------------------Trasforma-------------------------
%--------------------------------------------------------

trasformaMostro(Az,S,SNuovo,Ghiaccio,StatoP,Gemme):-
    nApplicabili(Az,S,Ghiaccio,Gemme,StatoP,N),
    trasformaN(Az,S,N,SNuovo).

trasformaMostroConMartello(Az,S,SNuovo,Ghiaccio,StatoP,GhiaccioFinale,Gemme):-
    nApplicabili(Az,S,[],Gemme,StatoP,N),
    trasformaN(Az,S,N,SNuovo),
    rimuoviGhiaccio(Az,S,SNuovo,Ghiaccio,GhiaccioFinale).

trasformaGhiaccio(Az,[G | ListaG],[SNuovoGhiaccio| NewLista],Ghiaccio,Gemme,StatoP):-
    nApplicabili(Az,G,Ghiaccio,Gemme,StatoP,N),
    trasformaN(Az,G,N,SNuovoGhiaccio),
    trasformaGhiaccio(Az, ListaG, NewLista ,Ghiaccio,Gemme,StatoP).

trasformaGhiaccio(_,[],[],_,_,_).



%--------------------------------------------------------
%--------------------N Applicabili-----------------------
%--------------------------------------------------------

nApplicabili(Az,S,Ghiaccio,Gemme,StatoP,1+N):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+ member(SNuovo,Ghiaccio),
    \+ member(SNuovo,Gemme),
    SNuovo \== StatoP,
    nApplicabili(Az,SNuovo,Ghiaccio,Gemme,StatoP,N).

nApplicabili(Az,S,Ghiaccio,Gemme,StatoP,0+N):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    member(SNuovo,Ghiaccio),
    nApplicabili(Az,SNuovo,Ghiaccio,Gemme,StatoP,N).

nApplicabili(Az,S,Ghiaccio,Gemme,StatoP,0+N):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    member(SNuovo,Gemme),
    nApplicabili(Az,SNuovo,Ghiaccio,Gemme,StatoP,N).

nApplicabili(Az,S,Ghiaccio,Gemme,StatoP,0+N):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    SNuovo == StatoP,
    nApplicabili(Az,SNuovo,Ghiaccio,Gemme,StatoP,N).

nApplicabili(Az,S,_,_,_,0):-
    \+ applicabile(Az,S).



%--------------------------------------------------------
%--------------------Applicabile-------------------------
%--------------------------------------------------------

applicabileTutto(Az,[G | Lista],Gemme):-
    applicabileStato(Az,G,Lista,Gemme).

applicabileTutto(Az,[G | Lista],Gemme):-
    \+ applicabileStato(Az,G,Lista,Gemme),
    applicabileTutto(Az,Lista,Gemme).


applicabileStato(Az,S,Ghiaccio,Gemme):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+ member(SNuovo,Gemme),
    member(SNuovo,Ghiaccio),
    applicabileStato(Az,SNuovo,Ghiaccio,Gemme).

applicabileStato(Az,S,Ghiaccio,Gemme):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+ member(SNuovo,Gemme),
    \+ member(SNuovo,Ghiaccio).

%--------------------------------------------------------
%-------------Applicabile Con Martello-------------------
%--------------------------------------------------------

applicabileTuttoMartello(Az,S,_,Gemme):-
    applicabile(Az,S),
    trasforma(Az,S,SNuovo),
    \+ member(SNuovo,Gemme).

applicabileTuttoMartello(Az,_,Ghiaccio,Gemme):-
    applicabileTutto(Az,Ghiaccio,Gemme).

applicabileTuttoMartello(Az,_,_,Gemme):-
    applicabileTutto(Az,Gemme,Gemme).

%--------------------------------------------------------
%---------------------Trasforma N------------------------
%--------------------------------------------------------

trasformaN(est,pos(R,C),N,pos(R,CDestra)):-CDestra is C+N.
trasformaN(ovest,pos(R,C),N,pos(R,CSin)):-CSin is C-N.
trasformaN(nord,pos(R,C),N,pos(RSopra,C)):-RSopra is R-N.
trasformaN(sud,pos(R,C),N,pos(RSotto,C)):-RSotto is R+N.



%--------------------------------------------------------
%----------------------Ghiaccio--------------------------
%--------------------------------------------------------

leggiGiaccio(T,[G | Lista]):-
    ghiaccio(G),
    \+ member(G,T),
    leggiGiaccio([G|T], Lista).

leggiGiaccio(_,[]).


rimuoviGhiaccio(Az,S,SNuovo,Ghiaccio,GhiaccioFin):-
    S \== SNuovo,
    trasforma(Az,S, S1),
    member(S1,Ghiaccio),
    rimuovi(S1,Ghiaccio,GhiaccioN),
    rimuoviGhiaccio(Az,S1,SNuovo,GhiaccioN,GhiaccioFin).

rimuoviGhiaccio(Az,S,SNuovo,Ghiaccio,GhiaccioFin):-
    S \== SNuovo,
    trasforma(Az,S, S1),
    \+ member(S1,Ghiaccio),
    rimuoviGhiaccio(Az,S1,SNuovo,Ghiaccio,GhiaccioFin).

rimuoviGhiaccio(_,S,SNuovo,Ghiaccio,Ghiaccio):-
    S == SNuovo.



%--------------------------------------------------------
%------------------------Gemme---------------------------
%--------------------------------------------------------

leggiGemme(T,[G | Lista]):-
    gemma(G),
    \+ member(G,T),
    leggiGemme([G|T], Lista).

leggiGemme(_,[]).


rimuoviGemme(Az,S,SNuovo,Gemme,GemmeFin):-
    S \== SNuovo,
    trasforma(Az,S, S1),
    member(S1,Gemme),
    rimuovi(S1,Gemme,GemmeN),
    rimuoviGemme(Az,S1,SNuovo,GemmeN,GemmeFin).

rimuoviGemme(Az,S,SNuovo,Gemme,GemmeFin):-
    S \== SNuovo,
    trasforma(Az,S, S1),
    \+ member(S1,Gemme),
    rimuoviGemme(Az,S1,SNuovo,Gemme,GemmeFin).

rimuoviGemme(_,S,SNuovo,Gemme,Gemme):-
    S == SNuovo.



%--------------------------------------------------------
%-------------------Gemme Contigue-----------------------
%--------------------------------------------------------

posizioniContigue([G | Lista], GemmeFinaliFinali, N, Cont):-
    vicini(G, GemmeFinaliFinali),
    Nnuovo is Cont + 1,
    posizioniContigue(Lista, GemmeFinaliFinali, N, Nnuovo).

posizioniContigue([G | Lista], GemmeFinaliFinali, N, Cont):-
    \+vicini(G, GemmeFinaliFinali),
    Nnuovo is Cont,
    posizioniContigue(Lista, GemmeFinaliFinali, N, Nnuovo).

posizioniContigue([], _, N, N).

vicini(pos(X,Y), [pos(X1,Y) | _]):- X is X1 + 1.
vicini(pos(X,Y), [pos(X1,Y) | _]):- X is X1 - 1.
vicini(pos(X,Y), [pos(X,Y1) | _]):- Y is Y1 + 1.
vicini(pos(X,Y), [pos(X,Y1) | _]):- Y is Y1 - 1.
vicini(pos(X,Y), [_ | ListaC]):- vicini(pos(X,Y), ListaC).



%--------------------------------------------------------
%----------------------Funzioni--------------------------
%--------------------------------------------------------

%----- rimuovi elem da un array
rimuovi(X,[X1 | Arr],[X1 | ArrFin]):-
    X \== X1,
    rimuovi(X, Arr, ArrFin).

rimuovi(X,[X | Arr],ArrFin):-
    rimuovi(X, Arr, ArrFin).

rimuovi(_,[],[]).

%----- inverti una lista
invOpt([],Temp,Temp).

invOpt([Head|Tail],Temp,Res):-
    invOpt(Tail,[Head|Temp],Res).

inv(L,R):-invOpt(L,[],R).

%----- restituisci primo elemento
firstElem([Head | _], Head).