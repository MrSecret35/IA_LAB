(bind ?i_1 (random 1 (length$  (find-all-facts  ((?var cp)) (and (= ?var:posizione 1) (>= ?var:valore 0))) ) ) )
(bind ?r_Pos1 (nth$ ?i_1 (find-all-facts  ((?var cp)) (and (= ?var:posizione 1) (>= ?var:valore 0))) )) 
(bind ?color1  (fact-slot-value ?randomPos1 colore))
(assert (cp (posizione 1) (colore blue) (valore 0)) )
(assert (cp (posizione 1) (colore green) (valore 0)) )
(assert (cp (posizione 1) (colore red) (valore 0)) )


  (cp (posizione 3) (colore ?pos3&~?pos2&~?pos1) (valore ?n&:(>= ?n 0)))
  (cp (posizione 4) (colore ?pos4&~?pos3&~?pos2&~?pos1) (valore ?n&:(>= ?n 0)))


---------------------------------------
|  g  |  m  |     cp    |   altre op
---------------------------------------
|  0  |  0  |   -100,0  | mettere -100 anche alle altre posizioni con lo stesso Colore
|  0  |  4  |   -100,0  | mettere -100 anche a tutti gli altri colori in tutte le pos (sono sicuro quei colori)
|  0  |  ?  |   -100,0  | +0,5 ai colori nelle altre posizioni
|  4  |  0  |    ---    | Vinto
|  ?  |  0  |      1,0  | mettere -100 ai colori nelle altre posizioni
|  ?  |  ?  |      1,5  |




--------------------------------
|  g  | Cosa Fare: c1 c2 c3 c4
--------------------------------
|  0  |  eliminare la combinazione corrente
|  1  |  eliminare tutte le combinazioni che NON hanno:
            c1 come 1 posizione
            OR c2 come 2 pos
            OR c3 come 3 pos
            OR c4 come 4 pos
          eliminare tutti i code che hanno
            c1 not in 1
            && c2 not in 2
            && c3 not in 3
            && c4 not in 4

          a b c d 
          b a d c 
          a c d b 
          


|  2  |   eliminare tutte le combinazioni che NON hanno:
            c1 c2 __ __
            c1 __ c3 __
            c1 __ __ c4
            __ c2 c3 __
            __ c2 __ c4
            __ __ c3 c4

            
|  3  |   eliminare tutte le combinazioni che NON hanno:
            c1 c2 c3 __
            c1 c2 __ c4
            c1 __ c3 c4
            __ c2 c3 c4

--------------------------------
|  mp  | Cosa Fare: c1 c2 c3 c4
--------------------------------
|  0  | eliminare la combinazione corrente 
|  1  | eliminare tutte le combinazioni che non hanno:
          c1 __ __ __
          __ c1 __ __
          __ __ c1 __
          __ __ __ c1
          OR
          c2 __ __ __
          __ c2 __ __
          __ __ c2 __
          __ __ __ c2
          OR
          c3 __ __ __
          __ c3 __ __
          __ __ c3 __
          __ __ __ c3
          OR
          c4 __ __ __
          __ c4 __ __
          __ __ c4 __
          __ __ __ c4

|  2  | eliminare tutte le combinazioni che non hanno:
          (c1 c2)(c1 c3)(c1 c4)(c2 c1)(c2 c3)(c2 c4)(c3 c1)(c3 c2)(c3 c4)(c4 c1)(c4 c2)(c4 c3)
          c1 c2 __ __
          c1 __ c2 __
          c1 __ __ c2
          __ c1 c2 __
          __ c1 __ c2
          __ __ c1 c2
          OR ...
|  3  |
|  4  |




a b c d 
 1

tutti dove non ci sono ne a ne b ne c ne d

