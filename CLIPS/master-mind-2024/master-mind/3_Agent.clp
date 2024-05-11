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
)

(deftemplate cps
  (multislot cp (cardinality 8 8))
)

;(colors blue green red yellow orange white black purple)
(deffacts colore-posizione
  (cp (posizione 1) (colore blue)   (valore 0) )
  (cp (posizione 1) (colore green)  (valore 0) )
  (cp (posizione 1) (colore red)    (valore 0) )
  (cp (posizione 1) (colore yellow) (valore 0) )
  (cp (posizione 1) (colore orange) (valore 0) )
  (cp (posizione 1) (colore white)  (valore 0) )
  (cp (posizione 1) (colore black)  (valore 0) )
  (cp (posizione 1) (colore purple) (valore 0) )
  ;---------------------------------------------
  (cp (posizione 2) (colore blue)   (valore 0) )
  (cp (posizione 2) (colore green)  (valore 0) )
  (cp (posizione 2) (colore red)    (valore 0) )
  (cp (posizione 2) (colore yellow) (valore 0) )
  (cp (posizione 2) (colore orange) (valore 0) )
  (cp (posizione 2) (colore white)  (valore 0) )
  (cp (posizione 2) (colore black)  (valore 0) )
  (cp (posizione 2) (colore purple) (valore 0) )
  ;---------------------------------------------
  (cp (posizione 3) (colore blue)   (valore 0) )
  (cp (posizione 3) (colore green)  (valore 0) )
  (cp (posizione 3) (colore red)    (valore 0) )
  (cp (posizione 3) (colore yellow) (valore 0) )
  (cp (posizione 3) (colore orange) (valore 0) )
  (cp (posizione 3) (colore white)  (valore 0) )
  (cp (posizione 3) (colore black)  (valore 0) )
  (cp (posizione 3) (colore purple) (valore 0) )
  ;---------------------------------------------
  (cp (posizione 4) (colore blue)   (valore 0) )
  (cp (posizione 4) (colore green)  (valore 0) )
  (cp (posizione 4) (colore red)    (valore 0) )
  (cp (posizione 4) (colore yellow) (valore 0) )
  (cp (posizione 4) (colore orange) (valore 0) )
  (cp (posizione 4) (colore white)  (valore 0) )
  (cp (posizione 4) (colore black)  (valore 0) )
  (cp (posizione 4) (colore purple) (valore 0) )
)
;  ---------------------------------------------
;  ------------ Scelta della mossa -------------
;  ---------------------------------------------

(defrule computer-player-step-0 (declare (salience -9))
  (status (step 0) (mode computer))
  =>
  (assert (guess (step 0) (g blue green red yellow) ))
  (printout t "La tua giocata allo step: 0 -> blue green red yellow"crlf)

  (pop-focus)
)

(defrule computer-player-step-1 (declare (salience -90))
  (status (step 1) (mode computer))
  =>
  (assert (guess (step 1) (g orange white black purple) ))
  (printout t "La tua giocata allo step: 1 -> orange white black purple " crlf)

  (pop-focus)
)

(defrule computer-player-step-n (declare (salience -10))
  (maxduration ?x)
  (status (step ?s&:(< ?s (- ?x 1))) (mode computer))
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
  (printout t "La tua giocata allo step: " ?s " -> " ?color1 " " ?color2 " " ?color3 " " ?color4 crlf)
  (bind ?x (length$  (find-all-facts  ((?var cp))  (< ?var:valore 0))) ) 
  (printout t "Numero possibilità eliminate: " ?x crlf)
  (pop-focus)
)

(defrule computer-player-step-last (declare (salience -10))
  (maxduration ?x)
  (status (step ?s&:(= ?s (- ?x 1))) (mode computer))

  (cp (posizione 1) (valore ?valP1&:(>= ?valP1 0)))
  (not (cp (posizione 1) (valore ?valP1_bis&:(> ?valP1_bis ?valP1))))

  (cp (posizione 2) (valore ?valP2&:(>= ?valP2 0)))
  (not (cp (posizione 2) (valore ?valP2_bis&:(> ?valP2_bis ?valP2))))

  (cp (posizione 3) (valore ?valP3&:(>= ?valP3 0)))
  (not (cp (posizione 3) (valore ?valP3_bis&:(> ?valP3_bis ?valP3))))

  (cp (posizione 4) (valore ?valP4&:(>= ?valP4 0)))
  (not (cp (posizione 4) (valore ?valP4_bis&:(> ?valP4_bis ?valP4))))
  =>
  (bind ?r_Pos1 (nth$ 1(find-all-facts ((?var cp)) (and (= ?var:posizione 1) (= ?var:valore ?valP1)))))
  (bind ?color1 (fact-slot-value ?r_Pos1 colore))

  (bind ?r_Pos2 (nth$ 1(find-all-facts ((?var cp)) (and (= ?var:posizione 2) (= ?var:valore ?valP2)))))
  (bind ?color2 (fact-slot-value ?r_Pos2 colore))

  (bind ?r_Pos3 (nth$ 1(find-all-facts ((?var cp)) (and (= ?var:posizione 3) (= ?var:valore ?valP3)))))
  (bind ?color3 (fact-slot-value ?r_Pos3 colore))

  (bind ?r_Pos4 (nth$ 1(find-all-facts ((?var cp)) (and (= ?var:posizione 4) (= ?var:valore ?valP4)))))
  (bind ?color4 (fact-slot-value ?r_Pos4 colore))

  ;(bind ?r_Pos1 (nth$ 0 (sort < (find-all-facts  ((?var cp)) (and (= ?var:posizione 1) (>= ?var:valore 0))) valore) ) )
  ;(bind ?color1  (fact-slot-value ?r_Pos1 colore))

  ;(bind ?r_Pos2 (nth$ 0 (sort < (find-all-facts  ((?var cp)) (and (= ?var:posizione 2) (>= ?var:valore 0))) valore) ) )
  ;(bind ?color2  (fact-slot-value ?r_Pos1 colore))

  ;(bind ?r_Pos3 (nth$ 0 (sort < (find-all-facts  ((?var cp)) (and (= ?var:posizione 3) (>= ?var:valore 0))) valore) ) )
  ;(bind ?color3  (fact-slot-value ?r_Pos1 colore))

  ;(bind ?r_Pos4 (nth$ 0 (sort < (find-all-facts  ((?var cp)) (and (= ?var:posizione 4) (>= ?var:valore 0))) valore) ) )
  ;(bind ?color4  (fact-slot-value ?r_Pos1 colore))

  (printout t "Ultimo GIRO: " ?x crlf)
  ;(assert (guess (step ?s) (g  ?color1 white green orange) ))
  (assert (guess (step ?s) (g  ?color1 ?color2 ?color3 ?color4) ))
  (printout t "La tua giocata allo step: " ?s " -> " ?color1 " " ?color2 " " ?color3 " " ?color4 crlf)
  (pop-focus)
)

;  ---------------------------------------------
;  -------- Esame mossa / Cambio Valori --------
;  ---------------------------------------------

(defrule aggiorna-pesi-0-0 (declare (salience -7))
  (answer (step ?s) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (printout t "Right placed " ?rp " missplaced " ?mp crlf)

  (delayed-do-for-all-facts ((?var cp)) (eq ?var:colore ?c1) (modify ?var (valore (- ?var:valore 100))) )
  (delayed-do-for-all-facts ((?var cp)) (eq ?var:colore ?c2) (modify ?var (valore (- ?var:valore 100))) )
  (delayed-do-for-all-facts ((?var cp)) (eq ?var:colore ?c3) (modify ?var (valore (- ?var:valore 100))) )
  (delayed-do-for-all-facts ((?var cp)) (eq ?var:colore ?c4) (modify ?var (valore (- ?var:valore 100))) )
)

(defrule aggiorna-pesi-0-X (declare (salience -7))
  (answer (step ?s) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(> ?mp 0)&:(< ?mp 4)) )
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )

  =>
  (printout t "Right placed " ?rp " missplaced " ?mp crlf)

  (bind ?cp1 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 1) (eq ?var:colore ?c1)) ) ) )
  (bind ?cp2 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 2) (eq ?var:colore ?c2)) ) ) )
  (bind ?cp3 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 3) (eq ?var:colore ?c3)) ) ) )
  (bind ?cp4 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 4) (eq ?var:colore ?c4)) ) ) )
  (bind ?v1  (fact-slot-value ?cp1 valore))
  (bind ?v2  (fact-slot-value ?cp2 valore))
  (bind ?v3  (fact-slot-value ?cp3 valore))
  (bind ?v4  (fact-slot-value ?cp4 valore))

  (modify ?cp1 (valore (- ?v1 100)) )
  (modify ?cp2 (valore (- ?v2 100)) )
  (modify ?cp3 (valore (- ?v3 100)) )
  (modify ?cp4 (valore (- ?v4 100)) )

  (delayed-do-for-all-facts ((?var cp)) (eq ?var:colore ?c1) (modify ?var (valore (+ ?var:valore 0.5))) )
  (delayed-do-for-all-facts ((?var cp)) (eq ?var:colore ?c2) (modify ?var (valore (+ ?var:valore 0.5))) )
  (delayed-do-for-all-facts ((?var cp)) (eq ?var:colore ?c3) (modify ?var (valore (+ ?var:valore 0.5))) )
  (delayed-do-for-all-facts ((?var cp)) (eq ?var:colore ?c4) (modify ?var (valore (+ ?var:valore 0.5))) )
)

(defrule aggiorna-pesi-X-0 (declare (salience -7))
  (answer (step ?s) (right-placed ?rp&:(> ?rp 0)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (printout t "Right placed " ?rp " missplaced " ?mp crlf)

  (bind ?cp1 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 1) (eq ?var:colore ?c1)) ) )) 
  (bind ?cp2 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 2) (eq ?var:colore ?c2)) ) ))
  (bind ?cp3 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 3) (eq ?var:colore ?c3)) ) ))
  (bind ?cp4 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 4) (eq ?var:colore ?c4)) ) ))
  (bind ?v1  (fact-slot-value ?cp1 valore))
  (bind ?v2  (fact-slot-value ?cp2 valore))
  (bind ?v3  (fact-slot-value ?cp3 valore))
  (bind ?v4  (fact-slot-value ?cp4 valore))

  (modify ?cp1 (valore (+ ?v1 1)) )
  (modify ?cp2 (valore (+ ?v2 1)) )
  (modify ?cp3 (valore (+ ?v3 1)) )
  (modify ?cp4 (valore (+ ?v4 1)) )

  (delayed-do-for-all-facts ((?var cp)) (and (eq ?var:colore ?c1) (neq ?var:posizione 1)) (modify ?var (valore (- ?var:valore 100))) )
  (delayed-do-for-all-facts ((?var cp)) (and (eq ?var:colore ?c2) (neq ?var:posizione 2)) (modify ?var (valore (- ?var:valore 100))) )
  (delayed-do-for-all-facts ((?var cp)) (and (eq ?var:colore ?c3) (neq ?var:posizione 3)) (modify ?var (valore (- ?var:valore 100))) )
  (delayed-do-for-all-facts ((?var cp)) (and (eq ?var:colore ?c4) (neq ?var:posizione 4)) (modify ?var (valore (- ?var:valore 100))) )
)

(defrule aggiorna-pesi-X-X-rp (declare (salience -7))
  (answer (step ?s) (right-placed ?rp&:(> ?rp 0)) (miss-placed ?mp&:(> ?mp 0)&:(> ?rp ?mp)))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )

  =>
  (printout t "Right placed " ?rp " missplaced " ?mp crlf)

  (bind ?cp1 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 1) (eq ?var:colore ?c1)) ) ))
  (bind ?cp2 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 2) (eq ?var:colore ?c2)) ) ))
  (bind ?cp3 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 3) (eq ?var:colore ?c3)) ) ))
  (bind ?cp4 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 4) (eq ?var:colore ?c4)) ) ))
  (bind ?v1  (fact-slot-value ?cp1 valore))
  (bind ?v2  (fact-slot-value ?cp2 valore))
  (bind ?v3  (fact-slot-value ?cp3 valore))
  (bind ?v4  (fact-slot-value ?cp4 valore))

  (modify ?cp1 (valore (+ ?v1 1.5)) )
  (modify ?cp2 (valore (+ ?v2 1.5)) )
  (modify ?cp3 (valore (+ ?v3 1.5)) )
  (modify ?cp4 (valore (+ ?v4 1.5)) )
)
(defrule aggiorna-pesi-X-X-mp (declare (salience -7))
  (answer (step ?s) (right-placed ?rp&:(> ?rp 0)) (miss-placed ?mp&:(> ?mp 0)&:(<= ?rp ?mp)))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )

  =>
  (printout t "Right placed " ?rp " missplaced " ?mp crlf)

  (bind ?cp1 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 1) (eq ?var:colore ?c1)) ) ))
  (bind ?cp2 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 2) (eq ?var:colore ?c2)) ) ))
  (bind ?cp3 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 3) (eq ?var:colore ?c3)) ) ))
  (bind ?cp4 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 4) (eq ?var:colore ?c4)) ) ))
  (bind ?v1  (fact-slot-value ?cp1 valore))
  (bind ?v2  (fact-slot-value ?cp2 valore))
  (bind ?v3  (fact-slot-value ?cp3 valore))
  (bind ?v4  (fact-slot-value ?cp4 valore))

  (modify ?cp1 (valore (+ ?v1 0.5)) )
  (modify ?cp2 (valore (+ ?v2 0.5)) )
  (modify ?cp3 (valore (+ ?v3 0.5)) )
  (modify ?cp4 (valore (+ ?v4 0.5)) )
)

(defrule aggiorna-pesi-0-4 (declare (salience -7))
  (answer (step ?s) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(= ?mp 4)))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )

  =>
  (printout t "Right placed " ?rp " missplaced " ?mp crlf)

  (bind ?cp1 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 1) (= ?var:colore ?c1)) ) ))
  (bind ?cp2 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 2) (= ?var:colore ?c2)) ) ))
  (bind ?cp3 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 3) (= ?var:colore ?c3)) ) ))
  (bind ?cp4 (nth$ 1 (find-fact ((?var cp)) (and (= ?var:posizione 4) (= ?var:colore ?c4)) ) ))
  (bind ?v1  (fact-slot-value ?cp1 valore))
  (bind ?v2  (fact-slot-value ?cp2 valore))
  (bind ?v3  (fact-slot-value ?cp3 valore))
  (bind ?v4  (fact-slot-value ?cp4 valore))

  (modify ?cp1 (valore (- ?v1 100)) )
  (modify ?cp2 (valore (- ?v2 100)) )
  (modify ?cp3 (valore (- ?v3 100)) )
  (modify ?cp4 (valore (- ?v4 100)) )

  (delayed-do-for-all-facts ((?var cp)) (neq (neq (neq (neq ?var:colore ?c1) ?var:colore ?c2) ?var:colore ?c3) ?var:colore ?c4) (modify ?var (valore (- ?var:valore 100))) )
)
