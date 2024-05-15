%------------------------------------------------
%-------------------- Andata -------------------- 
%------------------------------------------------

3 {assign_andata(G,S1,S2):squadra(S1),squadra(S2)} 3 :- giornata_andata(G).

% nessuna squadra giochi 2 volte in una giornata
:- assign_andata(G,S1,S2), assign_andata(G,S1,SS2), S2!=SS2.
:- assign_andata(G,S1,S2), assign_andata(G,SS1,S2), S1!=SS1.
:- assign_andata(G,S1,SX), assign_andata(G,SY,S1).

% nessuna squadra giochi contro se stessa
:- assign_andata(G,S1,S1).

%-------------------------------------------------
%-------------------- Ritorno -------------------- 
%-------------------------------------------------

3 {assign_ritorno(G,S1,S2):squadra(S1),squadra(S2)} 3 :- giornata_ritorno(G).

% nessuna squadra giochi 2 volte in una giornata
:- assign_ritorno(G,S1,S2), assign_ritorno(G,S1,SS2), S2!=SS2.
:- assign_ritorno(G,S1,S2), assign_ritorno(G,SS1,S2), S1!=SS1.
:- assign_ritorno(G,S1,SX), assign_ritorno(G,SY,S1).

% nessuna squadra giochi contro se stessa
:- assign_ritorno(G,S1,S1).

%-------------------------------------------------
%------------------- Controlli ------------------- 
%-------------------------------------------------

:- assign_andata(G,S1,S2), assign_ritorno(G,S1,S2).
:- assign_andata(G,S1,S2), assign_ritorno(G,S2,S1).