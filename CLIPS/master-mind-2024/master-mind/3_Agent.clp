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

(deftemplate cp
  (slot posizione)
  (slot colore)
  (slot valore)
)

(deftemplate cps
  (multislot cp (cardinality 8 8))
)

;(colors blue green red yellow orange white black purple)
(deffacts colore-posizione
  (cp (posizione 1) (colore blue) (valore 0))
  (cp (posizione 1) (colore green) (valore 0))
  (cp (posizione 1) (colore red) (valore 0))
  (cp (posizione 1) (colore yellow) (valore 0))
  (cp (posizione 1) (colore orange) (valore 0))
  (cp (posizione 1) (colore white) (valore 0))
  (cp (posizione 1) (colore black) (valore 0))
  (cp (posizione 1) (colore purple) (valore 0))
  ;-----------------------------------------------
  (cp (posizione 2) (colore blue) (valore 0))
  (cp (posizione 2) (colore green) (valore 0))
  (cp (posizione 2) (colore red) (valore 0))
  (cp (posizione 2) (colore yellow) (valore 0))
  (cp (posizione 2) (colore orange) (valore 0))
  (cp (posizione 2) (colore white) (valore 0))
  (cp (posizione 2) (colore black) (valore 0))
  (cp (posizione 2) (colore purple) (valore 0))
  ;-----------------------------------------------
  (cp (posizione 3) (colore blue) (valore 0))
  (cp (posizione 3) (colore green) (valore 0))
  (cp (posizione 3) (colore red) (valore 0))
  (cp (posizione 3) (colore yellow) (valore 0))
  (cp (posizione 3) (colore orange) (valore 0))
  (cp (posizione 3) (colore white) (valore 0))
  (cp (posizione 3) (colore black) (valore 0))
  (cp (posizione 3) (colore purple) (valore 0))
  ;-----------------------------------------------
  (cp (posizione 4) (colore blue) (valore 0))
  (cp (posizione 4) (colore green) (valore 0))
  (cp (posizione 4) (colore red) (valore 0))
  (cp (posizione 4) (colore yellow) (valore 0))
  (cp (posizione 4) (colore orange) (valore 0))
  (cp (posizione 4) (colore white) (valore 0))
  (cp (posizione 4) (colore black) (valore 0))
  (cp (posizione 4) (colore purple) (valore 0))
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
  
  (bind ?i_1 (random 1 (length$  (find-all-facts  ((?var cp)) (and (= ?var:posizione 1) (>= ?var:valore 0))) ) ) )
  (bind ?r_Pos1 (nth$ ?i_1 (find-all-facts  ((?var cp)) (and (= ?var:posizione 1) (>= ?var:valore 0))) )) 
  (bind ?color1  (fact-slot-value ?r_Pos1 colore))

  (bind ?i_2 (random 1 (length$  (find-all-facts  ((?var cp)) (and (= ?var:posizione 2) (>= ?var:valore 0))) ) ) )
  (bind ?r_Pos2 (nth$ ?i_2 (find-all-facts  ((?var cp)) (and (neq ?var:posizione ?color1) (and (= ?var:posizione 2) (>= ?var:valore 0)))) )) 
  (bind ?color2  (fact-slot-value ?r_Pos2 colore))


  =>
  (assert (guess (step ?s) (g  ?pos1 ?pos2 purple orange) ))
  (printout t "La tua giocata allo step: " ?s " -> " ?color1 " " ?color2 "crlf)
  (pop-focus)
)

;  ---------------------------------------------
;  -------- Esame mossa / Cambio Valori --------
;  ---------------------------------------------

(defrule stampa (declare (salience -10))
  (answer (step ?s) (right-placed ?rp) (miss-placed ?mp))
  ;?g <- (cp (posizione 1) (colore blue) (valore ?V1))
  =>
  ;(modify ?g (valore (+ ?V1 1)) )
  ;(printout t "Valore Blue " ?V1 crlf)
  (printout t "Right aaaaaaaaaaa placed " ?rp " missplaced " ?mp crlf)
  ;(assetr (fatto soluzione proposta))
)


(defrule stampa (declare (salience -1))
  (answer (step ?s) (right-placed ?rp) (miss-placed ?mp))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  ;?s1&:(eq(- ?s 1) ?s1)
  =>
  (printout t "La tua giocata allo step: " ?s " -> " ?c1 " " ?c2 " " ?c3 " " ?c4 crlf)
  (printout t "Right aaaaaaaaaaa placed " ?rp " missplaced " ?mp crlf)
  (bind ?x (- ?s 1))
  (printout t "Lo step prima era:  " ?x crlf)
)
