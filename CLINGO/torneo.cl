%------------------------------------------------
%-------------------- Andata -------------------- 
%------------------------------------------------

8 {assign_andata(G,S1,S2):squadra(S1),squadra(S2)} 8 :- giornata_andata(G).

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

% due squadre che appartengono alla stessa città non possono giocare in casa nello stesso giorno
:- assign_andata(G,S1,S2), sc(S1,C1), sc(S3,C1), assign_andata(G,S3,S4), S1!=S3.

% una squadra non deve giocare 3 volte consecitive in casa o fuori casa
:- assign_andata(G,S1,S2), assign_andata(G+1,S1,S3), assign_andata(G+2,S1,S4).
:- assign_andata(G,S2,S1), assign_andata(G+1,S3,S1), assign_andata(G+2,S4,S1).

%-------------------------------------------------
%-------------------- Ritorno -------------------- 
%-------------------------------------------------

8 {assign_ritorno(G,S1,S2):squadra(S1),squadra(S2)} 8 :- giornata_ritorno(G).

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

% due squadre che appartengono alla stessa città non possono giocare in casa nello stesso giorno
:- assign_ritorno(G,S1,S2), sc(S1,C1), sc(S3,C1), assign_ritorno(G,S3,S4), S1!=S3.

% una squadra non deve giocare 2 volte consecitive in casa o fuori casa
:- assign_ritorno(G,S1,S2), assign_ritorno(G+1,S1,S3), assign_ritorno(G+2,S1,S4).
:- assign_ritorno(G,S2,S1), assign_ritorno(G+1,S3,S1), assign_ritorno(G+2,S4,S1).


%-------------------------------------------------
%------------------- Controlli ------------------- 
%-------------------------------------------------

%non esistano giornate speculati
:- assign_andata(G,S1,S2), assign_ritorno(G,S1,S2).
:- assign_andata(G,S1,S2), assign_ritorno(G,S2,S1).

%una squadra non giochi 2 volte contro la stessa in casa o fuori casa
:- assign_andata(G,S1,S2), assign_ritorno(G1,S1,S2).

% una squadra non deve giocare 2 volte consecitive in casa o fuori casa 
%1-2
:- assign_andata(G,S1,S2), assign_ritorno(G+1,S1,S3), assign_ritorno(G+2,S1,S4).
:- assign_andata(G,S2,S1), assign_ritorno(G+1,S3,S1), assign_ritorno(G+2,S4,S1).
%2-1
:- assign_andata(G,S1,S2), assign_andata(G+1,S1,S3), assign_ritorno(G+2,S1,S4).
:- assign_andata(G,S2,S1), assign_andata(G+1,S3,S1), assign_ritorno(G+2,S4,S1).