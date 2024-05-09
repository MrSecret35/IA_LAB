;  ---------------------------------------------
;  --- Definizione del modulo e dei template ---
;  ---------------------------------------------
(defmodule AGENT (import MAIN ?ALL) (import GAME ?ALL) (export ?ALL))


(defrule human-player
  (status (step ?s) (mode human))
  =>
  (printout t "Your guess at step " ?s crlf)
  (bind $?input (readline))
  (assert (guess (step ?s) (g  (explode$ $?input)) ))
  (pop-focus)
)

(deftemplate cp ; colore-posizione
  (slot posizione) ;indica la posizione nella guess (1 2 3 o 4)
  (slot colore) ; contiene la stringa del colore
  (slot valore) ; valore associato a ciascuna lettera-posizione
  (slot stepM) ; contiene l'ultimo step in cui è stata modificata
)

(deftemplate cps
  (multislot cp (cardinality 8 8))
)

;(colors blue green red yellow orange white black purple)
(deffacts colore-posizione
  (cp (posizione 1) (colore blue)   (valore 0) (stepM -1))
  (cp (posizione 1) (colore green)  (valore 0) (stepM -1))
  (cp (posizione 1) (colore red)    (valore 0) (stepM -1))
  (cp (posizione 1) (colore yellow) (valore 0) (stepM -1))
  (cp (posizione 1) (colore orange) (valore 0) (stepM -1))
  (cp (posizione 1) (colore white)  (valore 0) (stepM -1))
  (cp (posizione 1) (colore black)  (valore 0) (stepM -1))
  (cp (posizione 1) (colore purple) (valore 0) (stepM -1))
  ;-----------------------------------------------
  (cp (posizione 2) (colore blue)   (valore 0) (stepM -1))
  (cp (posizione 2) (colore green)  (valore 0) (stepM -1))
  (cp (posizione 2) (colore red)    (valore 0) (stepM -1))
  (cp (posizione 2) (colore yellow) (valore 0) (stepM -1))
  (cp (posizione 2) (colore orange) (valore 0) (stepM -1))
  (cp (posizione 2) (colore white)  (valore 0) (stepM -1))
  (cp (posizione 2) (colore black)  (valore 0) (stepM -1))
  (cp (posizione 2) (colore purple) (valore 0) (stepM -1))
  ;-----------------------------------------------
  (cp (posizione 3) (colore blue)   (valore 0) (stepM -1))
  (cp (posizione 3) (colore green)  (valore 0) (stepM -1))
  (cp (posizione 3) (colore red)    (valore 0) (stepM -1))
  (cp (posizione 3) (colore yellow) (valore 0) (stepM -1))
  (cp (posizione 3) (colore orange) (valore 0) (stepM -1))
  (cp (posizione 3) (colore white)  (valore 0) (stepM -1))
  (cp (posizione 3) (colore black)  (valore 0) (stepM -1))
  (cp (posizione 3) (colore purple) (valore 0) (stepM -1))
  ;-----------------------------------------------
  (cp (posizione 4) (colore blue)   (valore 0) (stepM -1))
  (cp (posizione 4) (colore green)  (valore 0) (stepM -1))
  (cp (posizione 4) (colore red)    (valore 0) (stepM -1))
  (cp (posizione 4) (colore yellow) (valore 0) (stepM -1))
  (cp (posizione 4) (colore orange) (valore 0) (stepM -1))
  (cp (posizione 4) (colore white)  (valore 0) (stepM -1))
  (cp (posizione 4) (colore black)  (valore 0) (stepM -1))
  (cp (posizione 4) (colore purple) (valore 0) (stepM -1))
)

;  ---------------------------------------------
;  ------------ Scelta della mossa -------------
;  ---------------------------------------------

(defrule computer-player-step-0 (declare (salience -9))
  (status (step 0) (mode computer))
  =>
  (assert (guess (step 0) (g blue green red yellow) ))
  (pop-focus)
)

(defrule computer-player-step-1 (declare (salience -9))
  (status (step 1) (mode computer))
  =>
  (assert (guess (step 1) (g orange white black purple) ))
  (pop-focus)
)

(defrule computer-player-step-n (declare (salience -10))
  (status (step ?s) (mode computer))
  =>
  (bind ?i_1 (random 1 (length$  (find-all-facts  ((?var cp)) (and (= ?var:posizione 1) (>= ?var:valore 0))) ) ) )
  (bind ?r_Pos1 (nth$ ?i_1 (find-all-facts  ((?var cp)) (and (= ?var:posizione 1) (>= ?var:valore 0))) )) 
  (bind ?color1  (fact-slot-value ?r_Pos1 colore))

  (bind ?i_2 (random 1 (length$  (find-all-facts  ((?var cp)) (and (neq ?var:colore ?color1) (and (= ?var:posizione 2) (>= ?var:valore 0)))) ) ) )
  (bind ?r_Pos2 (nth$ ?i_2 (find-all-facts  ((?var cp)) (and (neq ?var:colore ?color1) (and (= ?var:posizione 2) (>= ?var:valore 0)))) )) 
  (bind ?color2  (fact-slot-value ?r_Pos2 colore))

  (bind ?i_3 (random 1 (length$  (find-all-facts  ((?var cp)) (and (neq ?var:colore ?color2) (and (neq ?var:colore ?color1) (and (= ?var:posizione 3) (>= ?var:valore 0))))) ) ) )
  (bind ?r_Pos3 (nth$ ?i_3 (find-all-facts  ((?var cp)) (and (neq ?var:colore ?color2) (and (neq ?var:colore ?color1) (and (= ?var:posizione 3) (>= ?var:valore 0))))) ))
  (bind ?color3  (fact-slot-value ?r_Pos3 colore))

  (bind ?i_4 (random 1 (length$  (find-all-facts  ((?var cp)) (and (neq ?var:colore ?color3) (and (neq ?var:colore ?color2) (and (neq ?var:colore ?color1) (and (= ?var:posizione 4) (>= ?var:valore 0)))))) ) ) )
  (bind ?r_Pos4 (nth$ ?i_4 (find-all-facts  ((?var cp)) (and (neq ?var:colore ?color3) (and (neq ?var:colore ?color2) (and (neq ?var:colore ?color1) (and (= ?var:posizione 4) (>= ?var:valore 0)))))) ))
  (bind ?color4  (fact-slot-value ?r_Pos4 colore))

  (assert (guess (step ?s) (g  ?color1 ?color2 ?color3 ?color4) ))
  (printout t "Colore: " ?color1 crlf)
  (pop-focus)
)

;  ---------------------------------------------
;  -------- Esame mossa / Cambio Valori --------
;  ---------------------------------------------

(defrule aggiorna-pesi-0-0 (declare (salience -7))
  (answer (step ?s) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (do-for-all-facts ((?var cp))  (and (eq ?var:colore ?c1) (neq ?var:stepM ?s))  (and (modify ?var (valore (- ?var:valore 100))) (modify ?var (put stepM ))) )
  (do-for-all-facts ((?var cp))  (and (eq ?var:colore ?c2) (neq ?var:stepM ?s))  (and (modify ?var (valore (- ?var:valore 100))) (modify ?var (put stepM ))) )
  (do-for-all-facts ((?var cp))  (and (eq ?var:colore ?c3) (neq ?var:stepM ?s))  (and (modify ?var (valore (- ?var:valore 100))) (modify ?var (put stepM ))) )
  (do-for-all-facts ((?var cp))  (and (eq ?var:colore ?c4) (neq ?var:stepM ?s))  (and (modify ?var (valore (- ?var:valore 100))) (modify ?var (put stepM ))) )
)

(defrule aggiorna-pesi-0-X (declare (salience -7))
  (answer (step ?s) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )

  ?cp1 <- (cp (posizione 1) (colore ?c1) (valore ?v1&:(>= ?v1 0)))
  ?cp2 <- (cp (posizione 2) (colore ?c2) (valore ?v2&:(>= ?v2 0)))
  ?cp3 <- (cp (posizione 3) (colore ?c3) (valore ?v3&:(>= ?v3 0)))
  ?cp4 <- (cp (posizione 4) (colore ?c4) (valore ?v4&:(>= ?v4 0)))
  =>
  
  (printout t "Valore Blue " ?v1 crlf)

  (modify ?cp1 (valore (- ?v1 100)) )
  (modify ?cp2 (valore (- ?v2 100)) )
  (modify ?cp3 (valore (- ?v3 100)) )
  (modify ?cp4 (valore (- ?v4 100)) )

  (printout t "Valore Blue " ?cp1 crlf)

  (do-for-all-facts ((?var cp))  (and (eq ?var:colore ?c1) (>= ?var:valore 0))  (modify ?var (valore (+ ?var:valore 0.5)) ) )
  (do-for-all-facts ((?var cp))  (and (eq ?var:colore ?c2) (>= ?var:valore 0))  (modify ?var (valore (+ ?var:valore 0.5)) ) )
  (do-for-all-facts ((?var cp))  (and (eq ?var:colore ?c3) (>= ?var:valore 0))  (modify ?var (valore (+ ?var:valore 0.5)) ) )
  (do-for-all-facts ((?var cp))  (and (eq ?var:colore ?c4) (>= ?var:valore 0))  (modify ?var (valore (+ ?var:valore 0.5)) ) )
)


(defrule stampa (declare (salience -10))
  (answer (step ?s) (right-placed ?rp) (miss-placed ?mp))
  ;?g <- (cp (posizione 1) (colore blue) (valore ?V1))
  =>
  ;(modify ?g (valore (+ ?V1 1)) )
  ;(printout t "Valore Blue " ?V1 crlf)
  (printout t "Right aaaaaaaaaaa placed " ?rp " missplaced " ?mp crlf)
  ;(assetr (fatto soluzione proposta))
)


(defrule stampa (declare (salience -9))
  (answer (step ?s) (right-placed ?rp) (miss-placed ?mp))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  ;?s1&:(eq(- ?s 1) ?s1)
  =>
  (printout t "La tua giocata allo step: " ?s " -> " ?c1 " " ?c2 " " ?c3 " " ?c4 crlf)
  (printout t "Right aaaaaaaaaaa placed " ?rp " missplaced " ?mp crlf)
  ;(bind ?x (- ?s 1))
  ;(printout t "Lo step prima era:  " ?x crlf)
)
