%------------------------------------------------
%-------------------- Andata -------------------- 
%------------------------------------------------

% Genera 8 partite per giornata per ogni giornata di andata
8 {assign_andata(G,S1,S2) : squadra(S1), squadra(S2), S1 != S2} 8 :- giornata_andata(G).

% Una squadra non gioca due volte nella stessa giornata
:- assign_andata(G,S1,S2), assign_andata(G,S1,S3), S2 != S3.
:- assign_andata(G,S1,S2), assign_andata(G,S3,S2), S1 != S3.

% Nessuna squadra gioca contro se stessa
:- assign_andata(G,S1,S1).

% Nessuna partita invertita nello stesso girone
:- assign_andata(G,S1,S2), assign_andata(G1,S2,S1), G != G1.

% Due squadre della stessa città non giocano in casa nello stesso giorno
:- assign_andata(G,S1,S2), sc(S1,C), sc(S3,C), assign_andata(G,S3,S4), S1 != S3.

% Nessuna squadra gioca 3 volte consecutive in casa o fuori
:- assign_andata(G,S1,S2), assign_andata(G1,S1,S3), assign_andata(G2,S1,S4), G + 1 == G1, G + 2 == G2.
:- assign_andata(G,S2,S1), assign_andata(G1,S3,S1), assign_andata(G2,S4,S1), G + 1 == G1, G + 2 == G2.

%-------------------------------------------------
%-------------------- Ritorno -------------------- 
%-------------------------------------------------

% Genera 8 partite per giornata per ogni giornata di ritorno
8 {assign_ritorno(G,S1,S2) : squadra(S1), squadra(S2), S1 != S2} 8 :- giornata_ritorno(G).

% Una squadra non gioca due volte nella stessa giornata
:- assign_ritorno(G,S1,S2), assign_ritorno(G,S1,S3), S2 != S3.
:- assign_ritorno(G,S1,S2), assign_ritorno(G,S3,S2), S1 != S3.

% Nessuna squadra gioca contro se stessa
:- assign_ritorno(G,S1,S1).

% Nessuna partita invertita nello stesso girone
:- assign_ritorno(G,S1,S2), assign_ritorno(G1,S2,S1), G != G1.

% Due squadre della stessa città non giocano in casa nello stesso giorno
:- assign_ritorno(G,S1,S2), sc(S1,C), sc(S3,C), assign_ritorno(G,S3,S4), S1 != S3.

% Nessuna squadra gioca 2 volte consecutive in casa o fuori
:- assign_ritorno(G,S1,S2), assign_ritorno(G1,S1,S3), assign_ritorno(G2,S1,S4), G + 1 == G1, G + 2 == G2.
:- assign_ritorno(G,S2,S1), assign_ritorno(G1,S3,S1), assign_ritorno(G2,S4,S1), G + 1 == G1, G + 2 == G2.

%-------------------------------------------------
%------------------- Controlli ------------------- 
%-------------------------------------------------

% Nessuna giornata speculare tra andata e ritorno
:- assign_andata(G,S1,S2), assign_ritorno(G,S1,S2).
:- assign_andata(G,S1,S2), assign_ritorno(G,S2,S1).

% Nessuna squadra gioca 2 volte contro la stessa in casa o fuori casa
:- assign_andata(G,S1,S2), assign_ritorno(G1,S1,S2).

% Nessuna squadra gioca 2 volte consecutive in casa o fuori casa tra andata e ritorno
:- assign_andata(G,S1,S2), assign_ritorno(G1,S1,S3), assign_ritorno(G2,S1,S4), G + 1 == G1, G + 2 == G2. 
:- assign_andata(G,S2,S1), assign_ritorno(G1,S3,S1), assign_ritorno(G2,S4,S1), G + 1 == G1, G + 2 == G2.
:- assign_andata(G,S1,S2), assign_andata(G1,S1,S3), assign_ritorno(G2,S1,S4), G + 1 == G1, G + 2 == G2.
:- assign_andata(G,S2,S1), assign_andata(G1,S3,S1), assign_ritorno(G2,S4,S1), G + 1 == G1, G + 2 == G2.
