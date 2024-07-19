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
(deftemplate mp
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



;  ---------------------------------------------
;  ------------ Scelta della mossa -------------
;  ---------------------------------------------

(defrule computer-player-step-0 (declare (salience -9))
  (status (step 0) (mode computer))
  =>
  (bind ?l (length (find-all-facts ((?var code)) TRUE)))
  (printout t "mosse rimanenti  " ?l crlf)

  (assert (guess (step 0) (g blue red yellow green) ))
  (printout t "La tua giocata allo step: 0 -> blue red yellow green"crlf)

  (pop-focus)
)

(defrule computer-player-step-n (declare (salience -10))
  (status (step ?n) (mode computer))
  =>
  (bind ?l (length (find-all-facts ((?var code)) TRUE)))
  (printout t "mosse rimanenti  " ?l crlf)

  (bind ?i (random 0 ?l) )
  (bind ?g (nth ?i (find-all-facts ((?var code)) TRUE) ) )

  (bind ?c1  (fact-slot-value ?g p1))
  (bind ?c2  (fact-slot-value ?g p2))
  (bind ?c3  (fact-slot-value ?g p3))
  (bind ?c4  (fact-slot-value ?g p4))

  (assert (guess (step ?n) (g ?c1 ?c2 ?c3 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?c2 " " ?c3 " " ?c4 crlf)

  (pop-focus)
)



;  ---------------------------------------------
;  -------- Esame mossa / Cambio Valori --------
;  ---------------------------------------------

(defrule aggiorna-pesi (declare (salience -7))
  (answer (step ?s) (right-placed ?rp) (miss-placed ?mp))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (assert (rp (valore ?rp) (step ?s)))
  (assert (mp (valore ?mp) (step ?s)))
  ;(assert (miss-placed ?mp))

  (printout t "Right placed " ?rp " missplaced " ?mp crlf)

)



;  ---------------------------------------------
;  --------------- Right Placed ----------------
;  ---------------------------------------------

(defrule elimina_facts_rp_0 (declare (salience -7))
  (rp (valore 0) (step ?s))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (delayed-do-for-all-facts ((?var code)) 
                            (or (or (or
                            (eq ?var:p1 ?c1)
                            (eq ?var:p2 ?c2) ) 
                            (eq ?var:p3 ?c3) ) 
                            (eq ?var:p4 ?c4) )
                            (retract ?var)
  )
)

(defrule elimina_facts_rp_1 (declare (salience -7))
  (rp (valore 1) (step ?s))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  ?g <- (code (p1 ?color_1&:(neq ?c1 ?color_1) ) 
        (p2 ?color_2&:(neq ?c2 ?color_2) )
        (p3 ?color_3&:(neq ?c3 ?color_3) ) 
        (p4 ?color_4&:(neq ?c4 ?color_4) ) )
  =>
  (retract ?g)
)

(defrule elimina_facts_rp_2 (declare (salience -7))
  (rp (valore 2) (step ?s))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (delayed-do-for-all-facts ((?var code)) 
                            (not ( or (or (or (or (or
                              (and (eq ?var:p1 ?c1) (eq ?var:p2 ?c2) )
                              (and (eq ?var:p1 ?c1) (eq ?var:p3 ?c3) ) )
                              (and (eq ?var:p1 ?c1) (eq ?var:p4 ?c4) ) )
                              (and (eq ?var:p2 ?c2) (eq ?var:p3 ?c3) ) )
                              (and (eq ?var:p2 ?c2) (eq ?var:p4 ?c4) ) )
                              (and (eq ?var:p3 ?c3) (eq ?var:p4 ?c4) )  
                            ) )
                            (retract ?var)
  )
)

(defrule elimina_facts_rp_3 (declare (salience -7))
  (rp (valore 3) (step ?s))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (delayed-do-for-all-facts ((?var code)) 
                            (not (or (or (or (and (and (eq ?var:p1 ?c1) (eq ?var:p2 ?c2))(eq ?var:p3 ?c3))
                            (and (and (eq ?var:p1 ?c1) (eq ?var:p2 ?c2))(eq ?var:p4 ?c4)))
                            (and (and (eq ?var:p1 ?c1) (eq ?var:p3 ?c3))(eq ?var:p4 ?c4)))
                            (and (and (eq ?var:p2 ?c2) (eq ?var:p3 ?c3))(eq ?var:p4 ?c4))))
                            (retract ?var)
  )
)



;  ---------------------------------------------
;  ---------------- Miss Placed ----------------
;  ---------------------------------------------
(defrule elimina_facts_mp_0 (declare (salience -7))
  (mp (valore 0) (step ?s))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (delayed-do-for-all-facts ((?var code)) 
                            (and (and (and 
                            (or (or (eq ?var:p2 ?c1) (eq ?var:p3 ?c1) ) (eq ?var:p4 ?c1) )
                            (or (or (eq ?var:p1 ?c2) (eq ?var:p3 ?c2) ) (eq ?var:p4 ?c2) ) )
                            (or (or (eq ?var:p1 ?c3) (eq ?var:p2 ?c3) ) (eq ?var:p4 ?c3) ) )
                            (or (or (eq ?var:p1 ?c4) (eq ?var:p2 ?c4) ) (eq ?var:p3 ?c4) ) )
                            (retract ?var)
  )
)

(defrule elimina_facts_mp_1 (declare (salience -7))
  (mp (valore 1) (step ?s))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (delayed-do-for-all-facts ((?var code)) 
                            (and (and (and 
                            (not (or (or (or (eq ?var:p1 ?c1) (eq ?var:p2 ?c1) ) (eq ?var:p3 ?c1) )(eq ?var:p4 ?c1) ) )
                            (not (or (or (or (eq ?var:p1 ?c2) (eq ?var:p2 ?c2) ) (eq ?var:p3 ?c2) )(eq ?var:p4 ?c2) ) ) )
                            (not (or (or (or (eq ?var:p1 ?c3) (eq ?var:p2 ?c3) ) (eq ?var:p3 ?c3) )(eq ?var:p4 ?c3) ) ) )
                            (not (or (or (or (eq ?var:p1 ?c4) (eq ?var:p2 ?c4) ) (eq ?var:p3 ?c4) )(eq ?var:p4 ?c4) ) ) )
                            (retract ?var)
  )
)

(defrule elimina_facts_mp_2 (declare (salience -7))
  (mp (valore 2) (step ?s))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (delayed-do-for-all-facts ((?var code))
                             
                            (and (and (and (and (and 
                            (not (and (or (or (or (eq ?var:p1 ?c1) (eq ?var:p2 ?c1) ) (eq ?var:p3 ?c1) )(eq ?var:p4 ?c1) ) 
                                      (or (or (or (eq ?var:p1 ?c2) (eq ?var:p2 ?c2) ) (eq ?var:p3 ?c2) )(eq ?var:p4 ?c2) ) ) )
                            (not (and (or (or (or (eq ?var:p1 ?c1) (eq ?var:p2 ?c1) ) (eq ?var:p3 ?c1) )(eq ?var:p4 ?c1) ) 
                                      (or (or (or (eq ?var:p1 ?c3) (eq ?var:p2 ?c3) ) (eq ?var:p3 ?c3) )(eq ?var:p4 ?c3) ) ) ) )
                            (not (and (or (or (or (eq ?var:p1 ?c1) (eq ?var:p2 ?c1) ) (eq ?var:p3 ?c1) )(eq ?var:p4 ?c1) ) 
                                      (or (or (or (eq ?var:p1 ?c4) (eq ?var:p2 ?c4) ) (eq ?var:p3 ?c4) )(eq ?var:p4 ?c4) ) ) ) )
                            (not (and (or (or (or (eq ?var:p1 ?c2) (eq ?var:p2 ?c2) ) (eq ?var:p3 ?c2) )(eq ?var:p4 ?c2) ) 
                                      (or (or (or (eq ?var:p1 ?c3) (eq ?var:p2 ?c3) ) (eq ?var:p3 ?c3) )(eq ?var:p4 ?c3) ) ) ) )
                            (not (and (or (or (or (eq ?var:p1 ?c2) (eq ?var:p2 ?c2) ) (eq ?var:p3 ?c2) )(eq ?var:p4 ?c2) ) 
                                      (or (or (or (eq ?var:p1 ?c4) (eq ?var:p2 ?c4) ) (eq ?var:p3 ?c4) )(eq ?var:p4 ?c4) ) ) ) )
                            (not (and (or (or (or (eq ?var:p1 ?c3) (eq ?var:p2 ?c3) ) (eq ?var:p3 ?c3) )(eq ?var:p4 ?c3) ) 
                                      (or (or (or (eq ?var:p1 ?c4) (eq ?var:p2 ?c4) ) (eq ?var:p3 ?c4) )(eq ?var:p4 ?c4) ) ) ) )
                            
                            (retract ?var)
  )
)

(defrule elimina_facts_mp_3 (declare (salience -7))
  (mp (valore 3) (step ?s))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (delayed-do-for-all-facts ((?var code))
                             
                            (and (and (and (not (and (and (or (or (or (eq ?var:p1 ?c1) (eq ?var:p2 ?c1) ) (eq ?var:p3 ?c1) )(eq ?var:p4 ?c1) ) 
                                      (or (or (or (eq ?var:p1 ?c2) (eq ?var:p2 ?c2) ) (eq ?var:p3 ?c2) )(eq ?var:p4 ?c2) ) ) 
                                      (or (or (or (eq ?var:p1 ?c3) (eq ?var:p2 ?c3) ) (eq ?var:p3 ?c3) )(eq ?var:p4 ?c3) ) ) )
                            (not (and (and (or (or (or (eq ?var:p1 ?c1) (eq ?var:p2 ?c1) ) (eq ?var:p3 ?c1) )(eq ?var:p4 ?c1) ) 
                                      (or (or (or (eq ?var:p1 ?c2) (eq ?var:p2 ?c2) ) (eq ?var:p3 ?c2) )(eq ?var:p4 ?c2) ) ) 
                                      (or (or (or (eq ?var:p1 ?c4) (eq ?var:p2 ?c4) ) (eq ?var:p3 ?c4) )(eq ?var:p4 ?c4) ) ) ))
                            (not (and (and (or (or (or (eq ?var:p1 ?c1) (eq ?var:p2 ?c1) ) (eq ?var:p3 ?c1) )(eq ?var:p4 ?c1) ) 
                                      (or (or (or (eq ?var:p1 ?c3) (eq ?var:p2 ?c3) ) (eq ?var:p3 ?c3) )(eq ?var:p4 ?c3) ) ) 
                                      (or (or (or (eq ?var:p1 ?c4) (eq ?var:p2 ?c4) ) (eq ?var:p3 ?c4) )(eq ?var:p4 ?c4) ) ) ))
                            (not (and (and (or (or (or (eq ?var:p1 ?c2) (eq ?var:p2 ?c2) ) (eq ?var:p3 ?c2) )(eq ?var:p4 ?c2) ) 
                                      (or (or (or (eq ?var:p1 ?c3) (eq ?var:p2 ?c3) ) (eq ?var:p3 ?c3) )(eq ?var:p4 ?c3) ) ) 
                                      (or (or (or (eq ?var:p1 ?c4) (eq ?var:p2 ?c4) ) (eq ?var:p3 ?c4) )(eq ?var:p4 ?c4) ) ) ))
                            
                            (retract ?var)
  )
)

(defrule elimina_facts_mp_4 (declare (salience -7))
  (mp (valore 4) (step ?s))
  (guess (step ?s) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (delayed-do-for-all-facts ((?var code)) 
                            (not (and (and (and 
                            (or (or (or (eq ?var:p1 ?c1) (eq ?var:p2 ?c1) ) (eq ?var:p3 ?c1) )(eq ?var:p4 ?c1) ) 
                            (or (or (or (eq ?var:p1 ?c2) (eq ?var:p2 ?c2) ) (eq ?var:p3 ?c2) )(eq ?var:p4 ?c2) ) )
                            (or (or (or (eq ?var:p1 ?c3) (eq ?var:p2 ?c3) ) (eq ?var:p3 ?c3) )(eq ?var:p4 ?c3) ) )
                            (or (or (or (eq ?var:p1 ?c4) (eq ?var:p2 ?c4) ) (eq ?var:p3 ?c4) )(eq ?var:p4 ?c4) ) ) )
                            (retract ?var)
  )
)