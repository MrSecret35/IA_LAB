ricerca(Cammino):-
    iniziale(S0),
    leggiGiaccio([],Ghiaccio),
    leggiGemme([],Gemme),!,

    euristicaMartello(S0,H),
    ricercaAStarMartello([(S0,0,H,Ghiaccio,Gemme,[])], [], GhiaccioFinale, GemmeFinali, Cammino1),
    %inv(Cammino1, CamminoInvertito1),
    %write(CamminoInvertito1), write("\n"),

    martello(S1),
    euristicaPortale(S1,H1),
    ricercaAStarPortale([(S1,0,H1, GhiaccioFinale, GemmeFinali,[])], [], _, GemmeFinaliFinali, Cammino2),
    
    inv(Cammino1, CamminoInvertito1),
    inv(Cammino2, CamminoInvertito2),

    % posizioniContigue(GemmeFinaliFinali,GemmeFinaliFinali,N,0),
    % %N \== 0, 
    % write("Gemme Contigue: "), write(N), write("\n"),

    tell('output.txt'),
    scriviCammino1(S0,CamminoInvertito1,Ghiaccio,_,Gemme,_),
    scriviCammino2(S1,CamminoInvertito2,GhiaccioFinale,_,GemmeFinali,_),
    told,
    write(CamminoInvertito1), write("\n"), 
    write(CamminoInvertito2), write("\n"),
    
    append(CamminoInvertito1,CamminoInvertito2,Cammino).

%--------------------------------------------------------
%-------------------Ricerca Martello---------------------
%--------------------------------------------------------

% ricercaAStarMartello([(S,G,H,Ghiaccio,Gemme,Cammino)| Open], Closed, Cammino)
% (S,G,H,Ghiaccio,Gemme,[])
%   S  posizione del mostro protagonista
%   G   Costo esatto dalla pos iniziale a S
%   H   Euristica di S fino alla pos finale
%   Cammino Cammino dalla pos iniziale a S
%  Open resto della lista open ordinata per costo totale

ricercaAStarMartello([(S,_,_, Gh,Ge,Cammino)| _], _, Gh, Ge, Cammino):-
    martello(S).

ricercaAStarMartello([(S,G,H, Gh,Ge, Cammino)| Open], Closed, GhiaccioFinale, GemmeFinali,  Risultato):-
    findall(Az, applicabileTutto(Az,[S | Gh],Ge),ElencoAz),
    elaboraMartello((S,G,H,Gh,Ge,Cammino), ElencoAz, Open, Closed, [(S_,G_,H_,Gh_,Ge_, Cammino_)| ListaNuovaOpen] ), !,
    ricercaAStarMartello([(S_,G_,H_,Gh_,Ge_, Cammino_)| ListaNuovaOpen], [(S_,G_,H_,Gh_,Ge_, Cammino_) | [(S,G,H,Gh,Ge, Cammino)| Closed]], GhiaccioFinale, GemmeFinali,  Risultato).

ricercaAStarMartello([(S,G,H,Gh,Ge, Cammino)| Open], Closed, [], [], ["Finish"]):-
    Open == [],
    findall(Az, applicabileTutto(Az,[S | Gh],Ge),ElencoAz),
    write("ops4"),write("\n"),
    elaboraMartello((S,G,H,Gh,Ge,Cammino), ElencoAz, Open, Closed, ListaNuovaOpen ),
    ListaNuovaOpen == [],!.


elaboraMartello((S,G,H,Gh,Ge,C), [Az| ElencoAz], Open, Closed, Res):-
    trasformaMostro(Az,S,SNuovo,Gh,S,Ge),
    trasformaGhiaccio(Az,Gh,GhNuovo, Gh,Ge,S),
    trasformaGhiaccio(Az,Ge,GeNuovo, Gh,Ge,S),
    euristicaMartello(SNuovo,HNuovo),
    \+ member((SNuovo,_,_,_,_,_), Closed),
    aggiungi((SNuovo,G+1,HNuovo,GhNuovo,GeNuovo,[Az|C]), Open, ListaNuovaOpen),
    elaboraMartello((S,G,H,Gh,Ge,C), ElencoAz, ListaNuovaOpen, Closed, Res).

elaboraMartello((S,G,H,Gh,Ge,C), [Az| ElencoAz], Open, Closed, Res):-
    trasformaMostro(Az,S,SNuovo,Gh,S,Ge),
    trasformaGhiaccio(Az,Gh,GhNuovo, Gh,Ge,S),
    trasformaGhiaccio(Az,Ge,GeNuovo, Gh,Ge,S),
    euristicaMartello(SNuovo,HNuovo),
    CostoSNuovo is G+1+HNuovo,
    member((SNuovo,_,_,_,_,_), Closed),
    restituisci(SNuovo,Closed,(SNuovo,G_,H_,_,_,C_)),
    CostoSNuovo_ is G_ + H_,
    CostoSNuovo =< CostoSNuovo_,
    C \== C_,
    aggiungi((SNuovo,G+1,HNuovo,GhNuovo,GeNuovo,[Az|C]), Open, ListaNuovaOpen),
    elaboraMartello((S,G,H,Gh,Ge,C), ElencoAz, ListaNuovaOpen, Closed, Res).

elaboraMartello((S,G,H,Gh,Ge,C), [Az| ElencoAz], Open, Closed, Res):-
    trasformaMostro(Az,S,SNuovo,Gh,S,Ge),
    trasformaGhiaccio(Az,Gh,_, Gh,Ge,S),
    trasformaGhiaccio(Az,Ge,_, Gh,Ge,S),
    euristicaMartello(SNuovo,HNuovo),
    CostoSNuovo is G+1+HNuovo,
    member((SNuovo,_,_,_,_,_), Closed),
    restituisci(SNuovo,Closed,(SNuovo,G_,H_,_,_,_)),
    CostoSNuovo_ is G_ + H_,
    CostoSNuovo > CostoSNuovo_,
    elaboraMartello((S,G,H,Gh,Ge,C), ElencoAz, Open, Closed, Res).

elaboraMartello(_, [], Open, _, Open).

euristicaMartello(pos(X,Y),Ris):-
    martello(pos(X1,Y1)),
    X2 is abs(X-X1),
    Y2 is abs(Y-Y1),
    Ris is X2 + Y2 .


%--------------------------------------------------------
%-------------------Ricerca Portale---------------------
%--------------------------------------------------------

ricercaAStarPortale([(S,_,_, Gh,Ge,Cammino)| _], _, Gh, Ge, Cammino):-
    finale(S).

ricercaAStarPortale([(S,G,H, Gh,Ge, Cammino)| Open], Closed, GhiaccioFinale, GemmeFinali,  Risultato):-
    findall(Az, applicabileTuttoMartello(Az,S,Gh,Ge),ElencoAz),
    elaboraPortale((S,G,H,Gh,Ge,Cammino), ElencoAz, Open, Closed, [(S_,G_,H_,Gh_,Ge_, Cammino_)| ListaNuovaOpen] ),!,
    ricercaAStarPortale([(S_,G_,H_,Gh_,Ge_, Cammino_)| ListaNuovaOpen], [(S_,G_,H_,Gh_,Ge_, Cammino_) | [(S,G,H,Gh,Ge, Cammino)| Closed]], GhiaccioFinale, GemmeFinali,  Risultato).

ricercaAStarPortale([(S,G,H,Gh,Ge, Cammino)| Open], Closed, [],[], ["Finish"]):-
    Open == [],
    findall(Az, applicabileTuttoMartello(Az,S,Gh,Ge),ElencoAz),
    elaboraPortale((S,G,H,Gh,Ge,Cammino), ElencoAz, Open, Closed, ListaNuovaOpen ),
    ListaNuovaOpen == [],!.


elaboraPortale((S,G,H,Gh,Ge,C), [Az| ElencoAz], Open, Closed, Res):-
    trasformaMostroConMartello(Az,S,SNuovo,Gh,S,GhNuovoDopoMostro,Ge),
    trasformaGhiaccio(Az,GhNuovoDopoMostro,GhNuovo,Gh,Ge,S),
    trasformaGhiaccio(Az,Ge,GeNuovo, Gh,Ge,S),
    euristicaPortale(SNuovo,HNuovo),
    \+ member((SNuovo,_,_,_,_,_), Closed),
    aggiungi((SNuovo,G+1,HNuovo,GhNuovo,GeNuovo,[Az|C]), Open, ListaNuovaOpen),
    elaboraPortale((S,G,H,Gh,Ge,C), ElencoAz, ListaNuovaOpen, Closed, Res).

elaboraPortale((S,G,H,Gh,Ge,C), [Az| ElencoAz], Open, Closed, Res):-
    trasformaMostroConMartello(Az,S,SNuovo,Gh,S,GhNuovoDopoMostro,Ge),
    trasformaGhiaccio(Az,GhNuovoDopoMostro,GhNuovo,Gh,Ge,S),
    trasformaGhiaccio(Az,Ge,GeNuovo, Gh,Ge,S),
    euristicaPortale(SNuovo,HNuovo),
    CostoSNuovo is G+1+HNuovo,
    member((SNuovo,_,_,_,_,_), Closed),
    restituisci(SNuovo,Closed,(SNuovo,G_,H_,_,_,C_)),
    CostoSNuovo_ is G_ + H_,
    CostoSNuovo =< CostoSNuovo_,
    C \== C_,
    aggiungi((SNuovo,G+1,HNuovo,GhNuovo,GeNuovo,[Az|C]), Open, ListaNuovaOpen),
    elaboraPortale((S,G,H,Gh,Ge,C), ElencoAz, ListaNuovaOpen, Closed, Res).

elaboraPortale((S,G,H,Gh,Ge,C), [Az| ElencoAz], Open, Closed, Res):-
    trasformaMostroConMartello(Az,S,SNuovo,Gh,S,GhNuovoDopoMostro,Ge),
    trasformaGhiaccio(Az,GhNuovoDopoMostro,_,Gh,Ge,S),
    trasformaGhiaccio(Az,Ge,_, Gh,Ge,S),
    euristicaPortale(SNuovo,HNuovo),
    CostoSNuovo is G+1+HNuovo,
    member((SNuovo,_,_,_,_,_), Closed),
    restituisci(SNuovo,Closed,(SNuovo,G_,H_,_,_,_)),
    CostoSNuovo_ is G_ + H_,
    CostoSNuovo > CostoSNuovo_,
    elaboraPortale((S,G,H,Gh,Ge,C), ElencoAz, Open, Closed, Res).

elaboraPortale(_, [], Open, _, Open).

euristicaPortale(pos(X,Y),Ris):-
    finale(pos(X1,Y1)),
    X2 is abs(X-X1),
    Y2 is abs(Y-Y1),
    Ris is X2 + Y2 .

%--------------------------------------------------------
%-------------------Funzioni ---------------------
%--------------------------------------------------------

%aggiunge in modo orditato un elemento alla lista
aggiungi((S,G,H,Gh,Ge,C), [(S_,G_,H_,Gh_,Ge_,C_)| Open], [(S,G,H,Gh,Ge,C)|[(S_,G_,H_,Gh_,Ge_,C_)|Open] ]):-
    Costo is G+H,
    Costo=<G_ + H_.

aggiungi((S,G,H,Gh,Ge,C), [], [(S,G,H,Gh,Ge,C)]).

aggiungi((S,G,H,Gh,Ge,C), [(S_,G_,H_,Gh_,Ge_,C_)| Open], [(S_,G_,H_,Gh_,Ge_,C_)| Lista]):-
    Costo is G+H,
    Costo>=G_ + H_,
    aggiungi((S,G,H,Gh,Ge,C), Open, Lista).


%Dato uno stato e una lista Restituisci i valori corrispondenti a quello stato
restituisci(S,[(S,G,H,Gh,Ge,C)| _],(S,G,H,Gh,Ge,C)).

restituisci(S,[(SX,_,_,_,_,_)| Closed],(S,G,H,Gh,Ge,C)):-
    S \== SX, 
    restituisci(S, Closed, (S,G,H,Gh,Ge,C)).