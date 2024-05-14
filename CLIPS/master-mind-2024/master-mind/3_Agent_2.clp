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

(deftemplate rp
  (slot valore)
  (slot step)
)

(deftemplate code
  (slot p1) (slot p2) (slot p3) (slot p4)
)

(deffacts colori
  (colore blue)  
  (colore green) 
  (colore red)   
  (colore yellow)
  (colore orange)
  (colore white) 
  (colore black) 
  (colore purple)
)

(defrule genera_combinazioni
  (colore ?color_1)
  (colore ?color_2&:(neq ?color_2 ?color_1))
  (colore ?color_3&:(neq ?color_3 ?color_2)&:(neq ?color_3 ?color_1))
  (colore ?color_4&:(neq ?color_4 ?color_3)&:(neq ?color_4 ?color_2)&:(neq ?color_4 ?color_1))
  =>
  (printout ?color_1 crlf)
  (assert (code (p1 ?color_1) (p2 ?color_2) (p3 ?color_3) (p4 ?color_4)) )
)

(defrule computer-player-step-0 (declare (salience -9))
  (status (step 0) (mode computer))
  =>
  (assert (guess (step 0) (g blue green red yellow) ))
  (printout t "La tua giocata allo step: 0 -> blue green red yellow"crlf)
  (pop-focus)
)

(defrule computer-player-step-0 (declare (salience -9))
  (status (step ?n) (mode computer))
  =>
  (assert (guess (step ?n) (g red blue green black) ))
  (printout t "La tua giocata allo step: 0 -> blue green red yellow"crlf)
  (pop-focus)
)

;  ---------------------------------------------
;  ------------ Scelta della mossa -------------
;  ---------------------------------------------


;  ---------------------------------------------
;  -------- Esame mossa / Cambio Valori --------
;  ---------------------------------------------

(defrule aggiorna-pesi (declare (salience -7))
  (answer (step ?s) (right-placed ?rp) (miss-placed ?mp))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (assert (rp (valore ?rp) (step ?s)))
  ;(assert (miss-placed ?mp))

  (printout t "Right placed " ?rp " missplaced " ?mp crlf)

)
;  ---------------------------------------------
;  -------- RP --------
;  ---------------------------------------------
(defrule elimina_facts_rp_1 (declare (salience -7))
  (rp (valore 1) (step ?s))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  ?g <- (code (p1 ?color_1&:(neq ?c1 ?color_1) ) 
        (p2 ?color_2&:(neq ?c2 ?color_2) )
        (p3 ?color_3&:(neq ?c3 ?color_3) ) 
        (p4 ?color_4&:(neq ?c4 ?color_4) ) )
  =>
  ;(printout t "elimino: " ?color_1 "  "  ?color_2 "  "  ?color_3 "  "  ?color_4 crlf)
  (retract ?g)
)
(defrule elimina_facts_rp_2 (declare (salience -7))
  (rp (valore 2) (step ?s))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (delayed-do-for-all-facts ((?var code)) 
                            (eq ?var:p1 blue)
                            (printout t "il valore: " ?var:p1 ) 
  )
)
(defrule elimina_facts_rp_3 (declare (salience -7))
  (rp (valore 2) (step ?s))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (delayed-do-for-all-facts ((?var code)) 
                            (or (or (or (and (and (eq ?var:p1 ?c1) (eq ?var:p2 ?c2))(eq ?var:p3 ?c3))
                            (and (and (eq ?var:p1 ?c1) (eq ?var:p2 ?c2))(eq ?var:p4 ?c4)))
                            (and (and (eq ?var:p1 ?c1) (eq ?var:p3 ?c3))(eq ?var:p4 ?c4)))
                            (and (and (eq ?var:p2 ?c2) (eq ?var:p3 ?c3))(eq ?var:p4 ?c4))) 
  )
)