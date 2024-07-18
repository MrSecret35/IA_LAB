squadra(a).
squadra(b).
squadra(c).
squadra(d).
squadra(e).
squadra(f).
squadra(g).
squadra(h).
squadra(i).
squadra(l).
squadra(m).
squadra(n).
squadra(o).
squadra(p).
squadra(q).
squadra(r).

sc(a,a1).
sc(b,b1).
sc(c,c1).
sc(d,d1).
sc(e,e1).
sc(f,f1).
sc(g,g1).
sc(h,h1).
sc(i,i1).
sc(l,l1).
sc(m,m1).
sc(n,n1).
sc(o,o1).
sc(p,p1).
sc(q,q1).
sc(r,r1).

giornata(1..15).

%------------------------------------------------
%-------------------- Andata -------------------- 
%------------------------------------------------

8 {assign_andata(G,S1,S2):squadra(S1),squadra(S2),S1<>S2} 8 :- giornata(G).

% nessuna squadra giochi 2 volte in una giornata
:- assign_andata(G,S1,S2), assign_andata(G,S1,SS2), S2<>SS2.
:- assign_andata(G,S1,S2), assign_andata(G,SS1,S2), S1<>SS1.
:- assign_andata(G,S1,SX), assign_andata(G,SY,S1).

%inserito durante l'assegnazione S1<>S2
% nessuna squadra giochi contro se stessa
% :- assign_andata(G,S1,S1).

% non esistano giornate con partine invertine nello stesso girone
:- assign_andata(G,S1,S2), assign_andata(G1,S2,S1).

% non esistano giornate con la stessa partita nello stesso girone
:- assign_andata(G,S1,S2), assign_andata(G1,S1,S2), G<>G1.

% due squadre che appartengono alla stessa città non possono giocare in casa nello stesso giorno
:- sc(S1,C1), sc(S3,C1), S1<>S3, assign_andata(G,S1,S2), assign_andata(G,S3,S4).

% una squadra non deve giocare 3 volte consecitive in casa o fuori casa
:- assign_andata(G,S1,S2), assign_andata(G+1,S1,S3), assign_andata(G+2,S1,S4).
:- assign_andata(G,S2,S1), assign_andata(G+1,S3,S1), assign_andata(G+2,S4,S1).


%-------------------------------------------------
%-------------------- Ritorno -------------------- 
%-------------------------------------------------

8 {assign_ritorno(G,S1,S2):squadra(S1),squadra(S2),S1<>S2,assign_andata(G1,S2,S1)} 8 :- giornata(G).

% nessuna squadra giochi 2 volte in una giornata
:- assign_ritorno(G,S1,S2), assign_ritorno(G,S1,SS2), S2<>SS2.
:- assign_ritorno(G,S1,S2), assign_ritorno(G,SS1,S2), S1<>SS1.
:- assign_ritorno(G,S1,SX), assign_ritorno(G,SY,S1).

%conttrollo inutile in quanto assign_andata(G1,S2,S1) implica
% nessuna squadra giochi contro se stessa
% :- assign_ritorno(G,S1,S1).

%conttrollo inutile in quanto assign_andata(G1,S2,S1) implica
% non esistano giornate con partine invertine nello stesso girone
% :- assign_ritorno(G,S1,S2), assign_ritorno(G1,S2,S1).

% non esistano giornate con la stessa partita nello stesso girone
:- assign_ritorno(G,S1,S2), assign_ritorno(G1,S1,S2), G<>G1.

% due squadre che appartengono alla stessa città non possono giocare in casa nello stesso giorno
:- sc(S1,C1), sc(S3,C1), S1<>S3, assign_ritorno(G,S1,S2), assign_ritorno(G,S3,S4).

% una squadra non deve giocare 2 volte consecitive in casa o fuori casa
:- assign_ritorno(G,S1,S2), assign_ritorno(G+1,S1,S3), assign_ritorno(G+2,S1,S4).
:- assign_ritorno(G,S2,S1), assign_ritorno(G+1,S3,S1), assign_ritorno(G+2,S4,S1).

%-------------------------------------------------
%------------------- Controlli ------------------- 
%-------------------------------------------------

%non necessario perchè assegnamento solo se assign_andata(G1,S2,S1)
%non esistano giornate speculati
%:- assign_andata(G,S1,S2), assign_ritorno(G,S1,S2).
%non nec essario secondo richiesta
%:- assign_andata(G,S1,S2), assign_ritorno(G,S2,S1).

%una squadra non giochi 2 volte contro la stessa in casa o fuori casa
%:- assign_andata(G,S1,S2), assign_ritorno(G1,S1,S2).

% non funziona
% una squadra non deve giocare 2 volte consecitive in casa o fuori casa 
%1-2
:- assign_andata(G,S1,S2), assign_ritorno(G+1,S1,S3), assign_ritorno(G+2,S1,S4).
:- assign_andata(G,S2,S1), assign_ritorno(G+1,S3,S1), assign_ritorno(G+2,S4,S1).
%2-1
:- assign_andata(G,S1,S2), assign_andata(G+1,S1,S3), assign_ritorno(G+2,S1,S4).
:- assign_andata(G,S2,S1), assign_andata(G+1,S3,S1), assign_ritorno(G+2,S4,S1).

%show
#show assign_andata/3.
#show assign_ritorno/3.