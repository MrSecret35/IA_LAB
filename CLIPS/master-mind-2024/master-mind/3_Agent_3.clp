;  ---------------------------------------------
;  --- Definizione del modulo e dei template ---
;  ---------------------------------------------
(defmodule AGENT (import MAIN ?ALL) (import GAME ?ALL) (export ?ALL))

(deftemplate color
  (slot name)
)
(deffacts my-colors
  (color (name blue))
  (color (name green))
  (color (name red))
  (color (name yellow))
  (color (name orange))
  (color (name white))
  (color (name black))
  (color (name purple))
)


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
  (assert (code (p1 blue) (p2 red) (p3 yellow) (p4 green) (rp 0) (mp 0)))
  (assert (codeS (p1 blank) (p2 blank) (p3 blank) (p4 blank) ))
  (printout t "La tua giocata allo step: 0 -> blue red yellow green"crlf)
  (pop-focus)
)

(defrule computer-stepN-0-0 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 blank) (p3 blank) (p4 blank))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 ?s2&:(neq ?s2 blank)) (p3 ?s3&:(neq ?s3 blank)) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (assert (guess (step ?n) (g ?s2 ?s3 ?s4 ?s1) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s2 " " ?s3 " " ?s4 " " ?s1 crlf)
  (modify ?cS (p1 ?s2) (p2 ?s3) (p3 ?s4) (p4 ?s1))
  (pop-focus)
)

;  ------------------------- 1 RP -------------------------
(defrule computer-stepN-1G-POS1 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 blank) (p3 blank) (p4 blank))
  ?cS <- (codeS (p1 blank) (p2 ?s2&:(neq ?s2 blank)) (p3 ?s3&:(neq ?s3 blank)) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (printout t "computer-stepN-1G-POS1------------------------------------------------------------------" crlf)
  (assert (guess (step ?n) (g ?c1 ?s3 ?s4 ?s2) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?s3 " " ?s4 " " ?s2 crlf)
  (modify ?cS (p1 blank) (p2 ?s3) (p3 ?s4) (p4 ?s2))
  (pop-focus)
)
(defrule computer-stepN-1G-POS2 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 ?c2&:(neq ?c2 blank)) (p3 blank) (p4 blank))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 blank) (p3 ?s3&:(neq ?s3 blank)) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (printout t "computer-stepN-1G-POS2------------------------------------------------------------------" crlf)
  (assert (guess (step ?n) (g ?s3 ?c2 ?s4 ?s1) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s3 " " ?c2 " " ?s4 " " ?s1 crlf)
  (modify ?cS (p1 ?s3) (p2 blank) (p3 ?s4) (p4 ?s1))
  (pop-focus)
)
(defrule computer-stepN-1G-POS3 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 blank) (p3 ?c3&:(neq ?c3 blank)) (p4 blank))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 ?s2&:(neq ?s2 blank)) (p3 blank) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (printout t "computer-stepN-1G-POS3------------------------------------------------------------------" crlf)
  (assert (guess (step ?n) (g ?s2 ?s4 ?c3 ?s1) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s2 " " ?s4 " " ?c3 " " ?s1 crlf)
  (modify ?cS (p1 ?s2) (p2 ?s4) (p3 blank) (p4 ?s1))
  (pop-focus)
)
(defrule computer-stepN-1G-POS4 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 blank) (p3 blank) (p4 ?c4&:(neq ?c4 blank)))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 ?s2&:(neq ?s2 blank)) (p3 ?s3&:(neq ?s3 blank)) (p4 blank) )
  =>
  (printout t "computer-stepN-1G-POS4------------------------------------------------------------------" crlf)
  (assert (guess (step ?n) (g ?s2 ?s3 ?s1 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s2 " " ?s3 " " ?s1 " " ?c4 crlf)
  (modify ?cS (p1 ?s2) (p2 ?s3) (p3 ?s1) (p4 blank))
  (pop-focus)
)

;  ------------------------- 2 RP -------------------------
(defrule computer-stepN-2G-POS1 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 ?c2&:(neq ?c2 blank)) (p3 blank) (p4 blank))
  ?cS <- (codeS (p1 blank) (p2 blank) (p3 ?s3&:(neq ?s3 blank)) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (assert (guess (step ?n) (g ?c1 ?c2 ?s4 ?s3) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?c2 " " ?s4 " " ?s3 crlf)
  (modify ?cS (p1 blank) (p2 blank) (p3 ?s4) (p4 ?s3))
  (pop-focus)
)
(defrule computer-stepN-2G-POS2 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 blank) (p3 ?c3&:(neq ?c3 blank)) (p4 blank))
  ?cS <- (codeS (p1 blank) (p2 ?s2&:(neq ?s2 blank)) (p3 blank) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (assert (guess (step ?n) (g ?c1 ?s4 ?c3 ?s2) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?s4 " " ?c3 " " ?s2 crlf)
  (modify ?cS (p1 blank) (p2 ?s4) (p3 blank) (p4 ?s2))
  (pop-focus)
)
(defrule computer-stepN-2G-POS3 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 blank) (p3 blank) (p4 ?c4&:(neq ?c4 blank)))
  ?cS <- (codeS (p1 blank) (p2 ?s2&:(neq ?s2 blank)) (p4 ?s3&:(neq ?s3 blank)) (p3 blank))
  =>
  (assert (guess (step ?n) (g ?c1 ?s3 ?s2 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?s3 " " ?s2 " " ?c4 crlf)
  (modify ?cS (p1 blank) (p2 ?s3) (p3 ?s2) (p4 ?c4))
  (pop-focus)
)
(defrule computer-stepN-2G-POS4 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 ?c2&:(neq ?c2 blank)) (p3 ?c3&:(neq ?c3 blank)) (p4 blank))
  ?cS <- (codeS (p2 ?s1&:(neq ?s1 blank)) (p1 blank) (p4 blank) (p3 ?s4&:(neq ?s4 blank)))
  =>
  (assert (guess (step ?n) (g ?s4 ?c2 ?c3 ?s1) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s4 " " ?c2 " " ?c3 " " ?s1 crlf)
  (modify ?cS (p1 ?s4) (p2 blank) (p3 blank) (p4 ?s1))
  (pop-focus)
)
(defrule computer-stepN-2G-POS5 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 ?c2&:(neq ?c2 blank)) (p3 blank) (p4 ?c4&:(neq ?c4 blank)))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 blank) (p3 ?s3&:(neq ?s3 blank)) (p4 blank))
  =>
  (assert (guess (step ?n) (g ?s3 ?c2 ?s1 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s3 " " ?c2 " " ?s1 " " ?c4 crlf)
  (modify ?cS (p1 ?s3) (p2 blank) (p3 ?s1) (p4 blank))
  (pop-focus)
)
(defrule computer-stepN-2G-POS6 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 blank) (p3 ?c3&:(neq ?c3 blank)) (p4 ?c4&:(neq ?c4 blank)))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 ?s2&:(neq ?s2 blank)) (p3 blank) (p4 blank))
  =>
  (assert (guess (step ?n) (g ?s2 ?s1 ?c3 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s2 " " ?s1 " " ?c3 " " ?c4 crlf)
  (modify ?cS (p1 ?s2) (p2 ?s1) (p3 blank) (p4 blank))
  (pop-focus)
)
;  ------------------------- 3 RP -------------------------
(defrule computer-stepN-3G-POS1 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 ?c2&:(neq ?c2 blank)) (p3 ?c3&:(neq ?c3 blank)) (p4 blank))
  ?cS <- (codeS (p1 blank) (p2 blank) (p3 blank) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (printout t "computer-stepN-3G-POS1------------------------------------------------------------------" crlf)
  (assert (guess (step ?n) (g ?c1 ?c2 ?c3 ?s4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?c2 " " ?c3 " " ?s4 crlf)
  ;(modify ?cS (p1 blank) (p2 blank) (p3 blank) (p4 ?s4))
  (pop-focus)
)
(defrule computer-stepN-3G-POS2 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 ?c2&:(neq ?c2 blank)) (p3 blank) (p4 ?c4&:(neq ?c4 blank)))
  ?cS <- (codeS (p1 blank) (p2 blank) (p3 ?s3&:(neq ?s3 blank)) (p4 blank))
  =>
  (printout t "computer-stepN-3G-POS2------------------------------------------------------------------" crlf)
  (assert (guess (step ?n) (g ?c1 ?c2 ?s3 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?c2 " " ?s3 " " ?c4 crlf)
  ;(modify ?cS (p1 blank) (p2 blank) (p3 ?s3) (p4 blank))
  (pop-focus)
)
(defrule computer-stepN-3G-POS3 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 blank) (p3 ?c3&:(neq ?c3 blank)) (p4 ?c4&:(neq ?c4 blank)))
  ?cS <- (codeS (p1 blank) (p2 ?s2&:(neq ?s2 blank)) (p3 blank) (p4 blank))
  =>
  (printout t "computer-stepN-3G-POS3------------------------------------------------------------------" crlf)
  (assert (guess (step ?n) (g ?c1 ?s2 ?c3 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?s2 " " ?c3 " " ?c4 crlf)
  ;(modify ?cS (p1 blank) (p2 ?s2) (p3 blank) (p4 blank))
  (pop-focus)
)
(defrule computer-stepN-3G-POS4 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 ?c2&:(neq ?c2 blank)) (p3 ?c3&:(neq ?c3 blank)) (p4 ?c4&:(neq ?c4 blank)))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 blank) (p3 blank) (p4 blank))
  =>
  (printout t "computer-stepN-3G-POS4------------------------------------------------------------------" crlf)
  (assert (guess (step ?n) (g ?s1 ?c2 ?c3 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s1 " " ?c2 " " ?c3 " " ?c4 crlf)
  ;(modify ?cS (p1 blank) (p2 blank) (p3 blank) (p4 ?s4))
  (pop-focus)
)
;  ---------------------------------------------
;  -------- Esame mossa / Cambio Valori --------
;  ---------------------------------------------

;---------------- 0 - 0 ---------------- 

(defrule step0N-0-0 (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step ?n) (g  ?c1 ?c2 ?c3 ?c4) )

  =>
  (printout t "------------------------------------------------------------" "Right placed " ?rp " missplaced "?mp crlf)
  
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  (assert (code (p1 blank) (p2 blank) (p3 blank) (p4 blank) (rp 0) (mp 0)))
  (do-for-fact ((?s1 color) (?s2 color) (?s3 color) (?s4 color)) 
    (and 
      (neq ?s1:name ?c1) (neq ?s1:name ?c2) (neq ?s1:name ?c3) (neq ?s1:name ?c4)
      (neq ?s2:name ?c1) (neq ?s2:name ?c2) (neq ?s2:name ?c3) (neq ?s2:name ?c4) (neq ?s2:name ?s1:name)
      (neq ?s3:name ?c1) (neq ?s3:name ?c2) (neq ?s3:name ?c3) (neq ?s3:name ?c4) (neq ?s3:name ?s2:name) (neq ?s3:name ?s1:name)
      (neq ?s4:name ?c1) (neq ?s4:name ?c2) (neq ?s4:name ?c3) (neq ?s4:name ?c4) (neq ?s4:name ?s3:name) (neq ?s4:name ?s2:name) (neq ?s4:name ?s1:name)
    )
    (assert (codeS (p1 ?s1:name) (p2 ?s2:name) (p3 ?s3:name) (p4 ?s4:name) ))
  )

  (printout t "------------------------------------------------------------------------------------------------" crlf)
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
  (printout t "-----------------------------------------" "Siamo in peggiore Right placed " ?rp " missplaced " ?mp crlf)
  (do-for-fact  ((?var code)) TRUE (retract ?var))
  (do-for-fact  ((?var codeS)) TRUE (retract ?var))
  (printout t "------------------------------------------------------------------------------------------------" crlf)

  
)
;SE MIGLIORE
(defrule stepN-0-Y-Migliore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )

  (code (p1 ?z1) (p2 ?z2) (p3 ?z3) (p4 ?z4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (> (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (printout t "-----------------------------------------" "Siamo in migliore Right placed " ?rp " missplaced " ?mp crlf)
  ;-------cancello tutto
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  ;-------assert questi code
  (assert (code (p1 blank) (p2 blank) (p3 blank) (p4 blank) (rp 0) (mp ?mp)))
  (assert (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4) ))
  (printout t "------------------------------------------------------------------------------------------------" crlf)
)
;SE UGUALE
; non fai nulla

;---------------- X - 0 ---------------- 
;SE PEGGIORE
(defrule X-0-Peggiore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )

  (code (p1 ?z1) (p2 ?z2) (p3 ?z3) (p4 ?z4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (< (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (printout t "-----------------------------------------" "Siamo in peggiore Right placed " ?rp " missplaced " ?mp crlf)
  (do-for-fact  ((?var code)) TRUE (retract ?var))
  (do-for-fact  ((?var codeS)) TRUE (retract ?var))
  (printout t "------------------------------------------------------------------------------------------------" crlf)
)
;SE MIGLIORE O UGUALE
(defrule 1X-0-Migliore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 1)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )

  (code (p1 ?c1) (p2 ?c2) (p3 ?c3) (p4 ?c4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (>= (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (printout t "-----------------------------------------" "Siamo in migliore Right placed " ?rp " missplaced " ?mp crlf)
  ;-------cancello tutto
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  (assert (code (p1 ?c1) (p2 blank) (p3 blank) (p4 blank) (rp 1) (mp 0)))
  (do-for-fact ((?s2 color) (?s3 color) (?s4 color)) 
    (and 
      (neq ?s2:name ?c1) (neq ?s2:name ?c2) (neq ?s2:name ?c3) (neq ?s2:name ?c4)
      (neq ?s3:name ?c1) (neq ?s3:name ?c2) (neq ?s3:name ?c3) (neq ?s3:name ?c4) (neq ?s3:name ?s2:name)
      (neq ?s4:name ?c1) (neq ?s4:name ?c2) (neq ?s4:name ?c3) (neq ?s4:name ?c4) (neq ?s4:name ?s3:name) (neq ?s4:name ?s2:name) 
    )
    (assert (codeS (p1 blank) (p2 ?s2:name) (p3 ?s3:name) (p4 ?s4:name) ))
  )

  (assert (code (p1 blank) (p2 ?c2) (p3 blank) (p4 blank) (rp 1) (mp 0)))
  (do-for-fact ((?s1 color) (?s3 color) (?s4 color)) 
    (and 
      (neq ?s1:name ?c1) (neq ?s1:name ?c2) (neq ?s1:name ?c3) (neq ?s1:name ?c4)
      (neq ?s3:name ?c1) (neq ?s3:name ?c2) (neq ?s3:name ?c3) (neq ?s3:name ?c4) (neq ?s3:name ?s1:name)
      (neq ?s4:name ?c1) (neq ?s4:name ?c2) (neq ?s4:name ?c3) (neq ?s4:name ?c4) (neq ?s4:name ?s3:name) (neq ?s4:name ?s1:name) 
    )
    (assert (codeS (p1 ?s1:name) (p2 blank) (p3 ?s3:name) (p4 ?s4:name) ))
  )

  (assert (code (p1 blank) (p2 blank) (p3 ?c3) (p4 blank) (rp 1) (mp 0)))
  (do-for-fact ((?s1 color) (?s2 color) (?s4 color)) 
    (and 
      (neq ?s1:name ?c1) (neq ?s1:name ?c2) (neq ?s1:name ?c3) (neq ?s1:name ?c4)
      (neq ?s2:name ?c1) (neq ?s2:name ?c2) (neq ?s2:name ?c3) (neq ?s2:name ?c4) (neq ?s2:name ?s1:name)
      (neq ?s4:name ?c1) (neq ?s4:name ?c2) (neq ?s4:name ?c3) (neq ?s4:name ?c4) (neq ?s4:name ?s2:name) (neq ?s4:name ?s1:name) 
    )
    (assert (codeS (p1 ?s1:name) (p2 ?s2:name) (p3 blank) (p4 ?s4:name) ))
  )

  (assert (code (p1 blank) (p2 blank) (p3 blank) (p4 ?c4) (rp 1) (mp 0)))
  (do-for-fact ((?s1 color) (?s2 color) (?s3 color)) 
    (and 
      (neq ?s1:name ?c1) (neq ?s1:name ?c2) (neq ?s1:name ?c3) (neq ?s1:name ?c4)
      (neq ?s2:name ?c1) (neq ?s2:name ?c2) (neq ?s2:name ?c3) (neq ?s2:name ?c4) (neq ?s2:name ?s1:name)
      (neq ?s3:name ?c1) (neq ?s3:name ?c2) (neq ?s3:name ?c3) (neq ?s3:name ?c4) (neq ?s3:name ?s2:name) (neq ?s3:name ?s1:name) 
    )
    (assert (codeS (p1 ?s1:name) (p2 ?s2:name) (p3 ?s3:name) (p4 blank)))
  )
  (printout t "------------------------------------------------------------------------------------------------" crlf)
)
(defrule 2X-0-Migliore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 2)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )

  (code (p1 ?c1) (p2 ?c2) (p3 ?c3) (p4 ?c4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (>= (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (printout t "-----------------------------------------" "Siamo in migliore Right placed " ?rp " missplaced " ?mp crlf)
  ;-------cancello tutto
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  (assert (code (p1 ?c1) (p2 ?c2) (p3 blank) (p4 blank) (rp 1) (mp 0)))
  (do-for-fact ((?s3 color) (?s4 color)) 
    (and 
      (neq ?s3:name ?c1) (neq ?s3:name ?c2) (neq ?s3:name ?c3) (neq ?s3:name ?c4)
      (neq ?s4:name ?c1) (neq ?s4:name ?c2) (neq ?s4:name ?c3) (neq ?s4:name ?c4) (neq ?s4:name ?s3:name)
    )
    (assert (codeS (p1 blank) (p2 blank) (p3 ?s3:name) (p4 ?s4:name) ))
  )

  (assert (code (p1 ?c1) (p2 blank) (p3 ?c3) (p4 blank) (rp 1) (mp 0)))
  (do-for-fact ((?s2 color) (?s4 color)) 
    (and 
      (neq ?s2:name ?c1) (neq ?s2:name ?c2) (neq ?s2:name ?c3) (neq ?s2:name ?c4)
      (neq ?s4:name ?c1) (neq ?s4:name ?c2) (neq ?s4:name ?c3) (neq ?s4:name ?c4) (neq ?s4:name ?s2:name) 
    )
    (assert (codeS (p1 blank) (p2 ?s2:name) (p3 blank) (p4 ?s4:name) ))
  )

  (assert (code (p1 ?c1) (p2 blank) (p3 blank) (p4 ?c4) (rp 1) (mp 0)))
  (do-for-fact ((?s2 color) (?s3 color)) 
    (and 
      (neq ?s2:name ?c1) (neq ?s2:name ?c2) (neq ?s2:name ?c3) (neq ?s2:name ?c4)
      (neq ?s3:name ?c1) (neq ?s3:name ?c2) (neq ?s3:name ?c3) (neq ?s3:name ?c4) (neq ?s3:name ?s2:name)
    )
    (assert (codeS (p1 blank) (p2 ?s2:name) (p3 ?s3:name) (p4 blank) ))
  )

  (assert (code (p1 blank) (p2 ?c2) (p3 ?c3) (p4 blank) (rp 1) (mp 0)))
  (do-for-fact ((?s1 color) (?s4 color)) 
    (and 
      (neq ?s1:name ?c1) (neq ?s1:name ?c2) (neq ?s1:name ?c3) (neq ?s1:name ?c4)
      (neq ?s4:name ?c1) (neq ?s4:name ?c2) (neq ?s4:name ?c3) (neq ?s4:name ?c4) (neq ?s4:name ?s1:name) 
    )
    (assert (codeS (p1 ?s1:name) (p2 blank) (p3 blank) (p4 ?s4:name) ))
  )

  (assert (code (p1 blank) (p2 ?c2) (p3 blank) (p4 ?c4) (rp 1) (mp 0)))
  (do-for-fact ((?s1 color) (?s3 color)) 
    (and 
      (neq ?s1:name ?c1) (neq ?s1:name ?c2) (neq ?s1:name ?c3) (neq ?s1:name ?c4)
      (neq ?s3:name ?c1) (neq ?s3:name ?c2) (neq ?s3:name ?c3) (neq ?s3:name ?c4) (neq ?s3:name ?s1:name)
    )
    (assert (codeS (p1 ?s1:name) (p2 blank) (p3 ?s3:name) (p4 blank) ))
  )

  (assert (code (p1 blank) (p2 blank) (p3 ?c3) (p4 ?c4) (rp 1) (mp 0)))
  (do-for-fact ((?s1 color) (?s2 color) ) 
    (and 
      (neq ?s1:name ?c1) (neq ?s1:name ?c2) (neq ?s1:name ?c3) (neq ?s1:name ?c4)
      (neq ?s2:name ?c1) (neq ?s2:name ?c2) (neq ?s2:name ?c3) (neq ?s2:name ?c4) (neq ?s2:name ?s1:name)
    )
    (assert (codeS (p1 ?s1:name) (p2 ?s2:name) (p3 blank) (p4 blank) ))
  )
  (printout t "------------------------------------------------------------------------------------------------" crlf)
)

(defrule 3X-0-Migliore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 3)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )

  (code (p1 ?c1) (p2 ?c2) (p3 ?c3) (p4 ?c4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (>= (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (printout t "-----------------------------------------" "Siamo in migliore Right placed " ?rp " missplaced " ?mp crlf)
  ;-------cancello tutto
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  (assert (code (p1 ?c1) (p2 ?c2) (p3 ?c3) (p4 blank) (rp 1) (mp 0)))
  (do-for-fact ((?s4 color)) 
    (and 
      (neq ?s4:name ?c1) (neq ?s4:name ?c2) (neq ?s4:name ?c3) (neq ?s4:name ?c4)
    )
    (assert (codeS (p1 blank) (p2 blank) (p3 blank) (p4 ?s4:name) ))
  )

  (assert (code (p1 blank) (p2 ?c2) (p3 blank) (p4 ?c4) (rp 1) (mp 0)))
    (do-for-fact ((?s3 color)) 
    (and 
      (neq ?s3:name ?c1) (neq ?s3:name ?c2) (neq ?s3:name ?c3) (neq ?s3:name ?c4)
    )
    (assert (codeS (p1 blank) (p2 blank) (p3 ?s3:name) (p4 blank) ))
  )

  (assert (code (p1 ?c1) (p2 blank) (p3 ?c3) (p4 ?c4) (rp 1) (mp 0)))
    (do-for-fact ((?s2 color)) 
    (and 
      (neq ?s2:name ?c1) (neq ?s2:name ?c2) (neq ?s2:name ?c3) (neq ?s2:name ?c4)
    )
    (assert (codeS (p1 blank) (p2 ?s2:name) (p3 blank) (p4 blank) ))
  )

  (assert (code (p1 blank) (p2 ?c2) (p3 ?c3) (p4 ?c4) (rp 1) (mp 0)))
    (do-for-fact ((?s1 color)) 
    (and 
      (neq ?s1:name ?c1) (neq ?s1:name ?c2) (neq ?s1:name ?c3) (neq ?s1:name ?c4)
    )
    (assert (codeS (p1 ?s1:name) (p2 blank) (p3 blank) (p4 blank) ))
  )
  (printout t "------------------------------------------------------------------------------------------------" crlf)
)
;---------------- X - Y ---------------- 


;SE PEGGIORE
(defrule X-Y-Peggiore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )

  (code (p1 ?z1) (p2 ?z2) (p3 ?z3) (p4 ?z4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (< (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (printout t "-----------------------------------------" "Siamo in peggiore Right placed " ?rp " missplaced " ?mp crlf)
  (do-for-fact  ((?var code)) TRUE (retract ?var)) 
  (do-for-fact  ((?var codeS)) TRUE (retract ?var))
  (printout t "------------------------------------------------------------------------------------------------" crlf)
)
;SE MIGLIORE O UGUALE
(defrule stepN-1X-Y (declare (salience -7))
  (answer (step ?n) (right-placed 1) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (printout t "-----------------------------------------" "Siamo in migliore Right placed " ?rp " missplaced " ?mp crlf)
  ;-------cancello tutto
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  (assert (code (p1 ?c1) (p2 blank) (p3 blank) (p4 blank) ))
  (assert (codeS (p1 blank) (p2 ?c2) (p3 ?c3) (p4 ?c4) ))

  (assert (code (p1 blank) (p2 ?c2) (p3 blank) (p4 blank) ))
  (assert (codeS (p1 ?c1) (p2 blank) (p3 ?c3) (p4 ?c4) ))

  (assert (code (p1 blank) (p2 blank) (p3 ?c3) (p4 blank) ))
  (assert (codeS (p1 ?c1) (p2 ?c2) (p3 blank) (p4 ?c4) ))

  (assert (code (p1 blank) (p2 blank) (p3 blank) (p4 ?c4) ))
  (assert (codeS (p1 ?c1) (p2 ?c2) (p3 ?c3) (p4 blank) ))

  (printout t "------------------------------------------------------------------------------------------------" crlf)
)

(defrule stepN-2X-Y (declare (salience -7))
  (answer (step ?n) (right-placed 2) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?c1 ?c2 ?c3 ?c4) )
  =>
  (printout t "-----------------------------------------" "Siamo in migliore Right placed " ?rp " missplaced " ?mp crlf)
  ;-------cancello tutto
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

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

  (printout t "------------------------------------------------------------------------------------------------" crlf)
)