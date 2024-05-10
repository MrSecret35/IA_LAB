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
