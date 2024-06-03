% Dominio



%--------------------------------------------------------
%----------------------Trasforma-------------------------
%--------------------------------------------------------

trasformaMostro(Az,S,SNuovo,Ghiaccio,StatoP,Gemme,GemmeN):-
    nApplicabili(Az,S,Ghiaccio,StatoP,N),
    trasformaN(Az,S,N,SNuovo),
    rimuoviGemme(Az,S,SNuovo,Gemme,GemmeN).

trasformaMostroConMartello(Az,S,SNuovo,Ghiaccio,StatoP,GhiaccioFinale,Gemme,GemmeN):-
    nApplicabili(Az,S,[],StatoP,N),
    trasformaN(Az,S,N,SNuovo),
    rimuoviGhiaccio(Az,S,SNuovo,Ghiaccio,GhiaccioFinale),
    rimuoviGemme(Az,S,SNuovo,Gemme,GemmeN).
    %rimuoviGhiaccio(Az,S,SNuovo,Gemma,Gemma2).

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
%-------------Applicabile Con Martello-------------------
%--------------------------------------------------------

applicabileTuttoMartello(Az,[G | _]):-
    applicabile(Az,G).

applicabileTuttoMartello(Az,[G | Lista]):-
    \+ applicabile(Az,G),
    applicabileTuttoMartello(Az,Lista).


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