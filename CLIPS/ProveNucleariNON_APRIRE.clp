(bind ?i_1 (random 1 (length$  (find-all-facts  ((?var cp)) (and (= ?var:posizione 1) (>= ?var:valore 0))) ) ) )
(bind ?r_Pos1 (nth$ ?i_1 (find-all-facts  ((?var cp)) (and (= ?var:posizione 1) (>= ?var:valore 0))) )) 
(bind ?color1  (fact-slot-value ?randomPos1 colore))
(assert (cp (posizione 1) (colore blue) (valore 0)) )
(assert (cp (posizione 1) (colore green) (valore 0)) )
(assert (cp (posizione 1) (colore red) (valore 0)) )


  (cp (posizione 3) (colore ?pos3&~?pos2&~?pos1) (valore ?n&:(>= ?n 0)))
  (cp (posizione 4) (colore ?pos4&~?pos3&~?pos2&~?pos1) (valore ?n&:(>= ?n 0)))