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

% non esistano giornate con partine invertine nello stesso girone
:- assign_andata(G,S1,S2), assign_andata(G1,S2,S1).

% non esistano giornate con la stessa partita nello stesso girone
:- assign_andata(G,S1,S2), assign_andata(G1,S1,S2), G!=G1.

%Due squadre che appartengono alla stessa città non possono giocare in casa nello stesso giorno
:- assign_andata(G,S1,S2), sc(S1,C1), sc(S3,C1), assign_andata(G,S3,S4), S1!=S3.



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

% non esistano giornate con partine invertine nello stesso girone
:- assign_ritorno(G,S1,S2), assign_ritorno(G1,S2,S1).

% non esistano giornate con la stessa partita nello stesso girone
:- assign_ritorno(G,S1,S2), assign_ritorno(G1,S1,S2), G!=G1.

%Due squadre che appartengono alla stessa città non possono giocare in casa nello stesso giorno
:- assign_ritorno(G,S1,S2), sc(S1,C1), sc(S3,C1), assign_ritorno(G,S3,S4), S1!=S3.

%-------------------------------------------------
%------------------- Controlli ------------------- 
%-------------------------------------------------

%non esistano giornate speculati
:- assign_andata(G,S1,S2), assign_ritorno(G,S1,S2).
:- assign_andata(G,S1,S2), assign_ritorno(G,S2,S1).

%una squadra non giochi 2 volte contro la stessa in casa o fuori casa
:- assign_andata(G,S1,S2), assign_ritorno(G1,S1,S2).