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

(deftemplate code
  (slot p1) (slot p2) (slot p3) (slot p4)
  (slot rp) (slot mp)
)
(deftemplate codeS
  (slot p1) (slot p2) (slot p3) (slot p4)
)

;  ----------------------------------------------
;  ------------- Scelta della mossa -------------
;  ----------------------------------------------

(defrule computer-step-0 (declare (salience -9))
  (status (step 0) (mode computer))
  =>
  (bind ?l (length (find-all-facts ((?var code)) TRUE)))
  (printout t "mosse rimanenti  " ?l crlf)

  (assert (guess (step 0) (g blue red yellow green) ))
  (assert (code (p1 blank) (p2 blank) (p3 blank) (p4 blank) (rp 0) (mp 0)))
  (assert (codeS (p1 blank) (p2 blank) (p3 blank) (p4 blank) ))
  (printout t "La tua giocata allo step: 0 -> blue red yellow green"crlf)
  (pop-focus)
)

(defrule computer-stepN-0-0 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 blank) (p3 blank) (p4 blank))
  (codeS (p1 ?c1) (p2 ?c2) (p3 ?c3) (p4 ?c4))
  =>
  (bind ?l (length (find-all-facts ((?var code)) TRUE)))
  (printout t "mosse rimanenti  " ?l crlf)

  (assert (guess (step ?n) (g ?c2 ?c3 ?c4 ?c1) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c2 " " ?c3 " " ?c4 " " ?c1 crlf)
  (pop-focus)
)
;  ------------------------- 1 RP -------------------------
(defrule computer-stepN-1G-POS1 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1) (p2 blank) (p3 blank) (p4 blank))
  (codeS (p1 blank) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  =>
  (assert (guess (step ?n) (g ?c1 ?s3 ?s4 ?s2) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?s3 " " ?s4 " " ?s2 crlf)
  (pop-focus)
)
(defrule computer-stepN-1G-POS2 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 ?c2) (p3 blank) (p4 blank))
  (codeS (p1 ?s1) (p2 blank) (p3 ?s3) (p4 ?s4))
  =>
  (assert (guess (step ?n) (g ?s3 ?c2 ?s4 ?s1) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s3 " " ?c2 " " ?s4 " " ?s1 crlf)
  (pop-focus)
)
(defrule computer-stepN-1G-POS3 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 blank) (p3 ?c3) (p4 blank))
  (codeS (p1 ?s1) (p2 ?s2) (p3 blank) (p4 ?s4))
  =>
  (assert (guess (step ?n) (g ?s2 ?s4 ?c3 ?s1) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s2 " " ?s4 " " ?c3 " " ?s1 crlf)
  (pop-focus)
)
(defrule computer-stepN-1G-POS4 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 blank) (p3 blank) (p4 ?c4))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 blank) )
  =>
  (assert (guess (step ?n) (g ?s2 ?s3 ?s1 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s2 " " ?s3 " " ?s1 " " ?c4 crlf)
  (pop-focus)
)
;  ------------------------- 2 RP -------------------------
(defrule computer-stepN-2G-POS1 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1) (p2 ?c2) (p3 blank) (p4 blank))
  (codeS (p1 blank) (p2 blank) (p3 ?s3) (p4 ?s4))
  =>
  (assert (guess (step ?n) (g ?c1 ?c2 ?s4 ?s3) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?c2 " " ?s4 " " ?s3 crlf)
  (pop-focus)
)
(defrule computer-stepN-2G-POS2 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1) (p2 blank) (p3 ?c3) (p4 blank))
  (codeS (p1 blank) (p2 ?s2) (p3 blank) (p4 ?s4))
  =>
  (assert (guess (step ?n) (g ?c1 ?s4 ?c3 ?s2) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?s4 " " ?c3 " " ?s2 crlf)
  (pop-focus)
)
(defrule computer-stepN-2G-POS3 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1) (p2 blank) (p3 blank) (p4 ?c4))
  (codeS (p1 blank) (p2 ?s2) (p4 ?s3) (p3 blank))
  =>
  (assert (guess (step ?n) (g ?c1 ?s3 ?s2 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?s3 " " ?s2 " " ?c4 crlf)
  (pop-focus)
)
(defrule computer-stepN-2G-POS4 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 ?c2) (p3 ?c3) (p4 blank))
  (codeS (p2 ?s1) (p1 blank) (p4 blank) (p3 ?s4))
  =>
  (assert (guess (step ?n) (g ?s4 ?c2 ?c3 ?s1) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s4 " " ?c2 " " ?c3 " " ?s1 crlf)
  (pop-focus)
)
(defrule computer-stepN-2G-POS5 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 ?c2) (p3 blank) (p4 ?c4))
  (codeS (p1 ?s1) (p2 blank) (p3 ?s3) (p4 blank))
  =>
  (assert (guess (step ?n) (g ?s3 ?c2 ?s1 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s3 " " ?c2 " " ?s1 " " ?c4 crlf)
  (pop-focus)
)
(defrule computer-stepN-2G-POS6 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 blank) (p3 ?c3) (p4 ?c4))
  (codeS (p1 ?s1) (p2 ?s2) (p3 blank) (p4 blank))
  =>
  (assert (guess (step ?n) (g ?s2 ?s1 ?c3 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s2 " " ?s1 " " ?c3 " " ?c4 crlf)
  (pop-focus)
)
;  ------------------------- 3 RP -------------------------
(defrule computer-stepN-3G-POS1 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1) (p2 ?c2) (p3 ?c3) (p4 blank))
  (codeS (p1 blank) (p2 blank) (p3 blank) (p4 ?s4))
  (color ?c4)
  =>
  (assert (guess (step ?n) (g ?c1 ?c2 ?c3 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?c2 " " ?c3 " " ?c4 crlf)
  (pop-focus)
)
(defrule computer-stepN-3G-POS2 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1) (p2 ?c2) (p3 blank) (p4 ?c4))
  (codeS (p1 blank) (p2 blank) (p3 ?s3) (p4 blank))
  (color ?c3)
  =>
  (assert (guess (step ?n) (g ?c1 ?c2 ?c3 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?c2 " " ?c3 " " ?c4 crlf)
  (pop-focus)
)
(defrule computer-stepN-3G-POS3 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1) (p2 blank) (p3 ?c3) (p4 ?c4))
  (codeS (p1 blank) (p2 ?s2) (p3 blank) (p4 blank))
  (color ?c2)
  =>
  (assert (guess (step ?n) (g ?c1 ?c2 ?c3 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?c2 " " ?c3 " " ?c4 crlf)
  (pop-focus)
)
(defrule computer-stepN-3G-POS4 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 ?c2) (p3 ?c3) (p4 ?c4))
  (codeS (p1 ?s1) (p2 blank) (p3 blank) (p4 blank))
  (color ?c1)
  =>  
  (assert (guess (step ?n) (g ?c1 ?c2 ?c3 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?c2 " " ?c3 " " ?c4 crlf)
  (pop-focus)
)
;  ---------------------------------------------
;  -------- Esame mossa / Cambio Valori --------
;  ---------------------------------------------

;---------------- 0 - 0 ---------------- 
(defrule step0-0-0 (declare (salience -7))
  (answer (step 0) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step 0) (g  ?c1 ?c2 ?c3 ?c4) )

  =>  
  (printout t "Right placed " ?rp " missplaced " ?mp crlf)

  (bind ?cs (find-fact  ((?var codeS)) TRUE))

  (printout t "Il codeS allo step: 0 -> " ?cs crlf)

  (do-for-fact  ((?var codeS)) TRUE (retract ?var))

  (assert (codeS (p1 orange) (p2 white) (p3 black) (p4 purple) ))
)

(defrule stepN-0-0 (declare (salience -7))
  (answer (step ?n&:(> ?n 0)) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step ?n) (g  ?c1 ?c2 ?c3 ?c4) )

  =>
  (printout t "Right placed " ?rp " missplaced " ?mp crlf)

  (bind ?c (find-fact  ((?var code)) TRUE))
  (bind ?cs (find-fact  ((?var codeS)) TRUE))
  (printout t "Il code allo step: 0 -> " ?c crlf)
  (printout t "Il codeS allo step: 0 -> " ?cs crlf)
  
  (do-for-fact  ((?var code)) TRUE (retract ?var))
  (do-for-fact  ((?var codeS)) TRUE (retract ?var))

  (assert (codeS (p1 orange) (p2 white) (p3 black) (p4 purple) ))
)

;---------------- 0 - Y ---------------- 
;SE PEGGIORE
(defrule stepN-0-Y-Peggiore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )

  (code (p1 ?z1) (p2 ?z2) (p3 ?z3) (p4 ?z4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (< (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (do-for-fact  ((?var codeS)) TRUE (retract ?var))
  (printout t "Siamo in peggiore Right placed " ?rp " missplaced " ?mp crlf)
)
;SE UGUALE
(defrule stepN-0-Y-Uguale (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )

  (code (p1 ?z1) (p2 ?z2) (p3 ?z3) (p4 ?z4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (= (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (do-for-fact  ((?var codeS)) TRUE (retract ?var))
  (printout t "Siamo in uguale Right placed " ?rp " missplaced " ?mp crlf)
  (assert (codeS (p1 ?s2) (p2 ?s3) (p3 ?s4) (p4 ?s1) ))
)
;SE MIGLIORE
(defrule stepN-0-Y-Migliore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )

  (code (p1 ?z1) (p2 ?z2) (p3 ?z3) (p4 ?z4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (> (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  (printout t "Siamo in migliore Right placed " ?rp " missplaced " ?mp crlf)
  (assert (code (p1 blank) (p2 blank) (p3 blank) (p4 blank) (rp 0) (mp ?mp)))
  (assert (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4) ))
)


;---------------- X - Y ---------------- 
(defrule stepN-1X-Y (declare (salience -7))
  (answer (step ?n) (right-placed 1) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (assert (code (p1 ?c1) (p2 blank) (p3 blank) (p4 blank) ))
  (assert (codeS (p1 blank) (p2 ?c2) (p3 ?c3) (p4 ?c4) ))

  (assert (code (p1 blank) (p2 ?c2) (p3 blank) (p4 blank) ))
  (assert (codeS (p1 ?c1) (p2 blank) (p3 ?c3) (p4 ?c4) ))

  (assert (code (p1 blank) (p2 blank) (p3 ?c3) (p4 blank) ))
  (assert (codeS (p1 ?c1) (p2 ?c2) (p3 blank) (p4 ?c4) ))

  (assert (code (p1 blank) (p2 blank) (p3 blank) (p4 ?c4) ))
  (assert (codeS (p1 ?c1) (p2 ?c2) (p3 ?c3) (p4 blank) ))

  (printout t "Right placed 1  missplaced " ?mp crlf)
)

(defrule stepN-2X-Y (declare (salience -7))
  (answer (step ?n) (right-placed 2) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (assert (code (p1 ?c1) (p2 ?c2) (p3 blank) (p4 blank) )) 
  (assert (codeS (p1 blank) (p2 blank) (p3 ?c3) (p4 ?c4) ))

  (assert (code (p1 ?c1) (p2 blank) (p3 ?c3) (p4 blank) ))
  (assert (codeS (p1 blank) (p2 ?c2) (p3 blank) (p4 ?c4) ))

  (assert (code (p1 ?c1) (p2 blank) (p3 blank) (p4 ?c4) ))
  (assert (codeS (p1 blank) (p2 ?c2) (p3 ?c3) (p4 blank) ))

  (assert (code (p1 blank) (p2 ?c2) (p3 ?c3) (p4 blank) ))
  (assert (codeS (p1 ?c1) (p2 blank) (p3 blank) (p4 ?c4) ))

  (assert (code (p1 blank) (p2 ?c2) (p3 blank) (p4 ?c4) ))
  (assert (codeS (p1 ?c1) (p2 blank) (p3 ?c3) (p4 blank) ))

  (assert (code (p1 blank) (p2 blank) (p3 ?c3) (p4 ?c4) ))
  (assert (codeS (p1 ?c1) (p2 ?c2) (p3 blank) (p4 blank) ))

  (printout t "Right placed 2  missplaced " ?mp crlf)
)