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
  (slot id)
)
(deftemplate codeS
  (slot p1) (slot p2) (slot p3) (slot p4)
  (slot id)
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
  (assert (code (p1 blue) (p2 red) (p3 yellow) (p4 green) (rp 0) (mp 0) (id 0)))
  (assert (codeS (p1 blank) (p2 blank) (p3 blank) (p4 blank) (id 0) ))
  (printout t "La tua giocata allo step: 0 -> blue red yellow green"crlf)
  (pop-focus)
)
(defrule computer-stepN-0-0 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 blank) (p3 blank) (p4 blank) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 ?s2&:(neq ?s2 blank)) (p3 ?s3&:(neq ?s3 blank)) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (assert (guess (step ?n) (g ?s2 ?s3 ?s4 ?s1) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s2 " " ?s3 " " ?s4 " " ?s1 crlf)
  (modify ?cS (p1 ?s2) (p2 ?s3) (p3 ?s4) (p4 ?s1))
  (pop-focus)
)

;  ---------------------------------------------
;  --------------- Scelta mossa ----------------
;  ---------------------------------------------

;  ------------------------- 1 RP -------------------------
(defrule computer-stepN-1G-POS1 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 blank) (p3 blank) (p4 blank) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 blank) (p2 ?s2&:(neq ?s2 blank)) (p3 ?s3&:(neq ?s3 blank)) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (assert (guess (step ?n) (g ?c1 ?s3 ?s4 ?s2) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?s3 " " ?s4 " " ?s2 crlf)
  (modify ?cS (p1 blank) (p2 ?s3) (p3 ?s4) (p4 ?s2))
  (pop-focus)
)
(defrule computer-stepN-1G-POS2 (declare (salience -10))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 ?c2&:(neq ?c2 blank)) (p3 blank) (p4 blank) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 blank) (p3 ?s3&:(neq ?s3 blank)) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (assert (guess (step ?n) (g ?s3 ?c2 ?s4 ?s1) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s3 " " ?c2 " " ?s4 " " ?s1 crlf)
  (modify ?cS (p1 ?s3) (p2 blank) (p3 ?s4) (p4 ?s1))
  (pop-focus)
)
(defrule computer-stepN-1G-POS3 (declare (salience -11))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 blank) (p3 ?c3&:(neq ?c3 blank)) (p4 blank) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 ?s2&:(neq ?s2 blank)) (p3 blank) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (assert (guess (step ?n) (g ?s2 ?s4 ?c3 ?s1) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s2 " " ?s4 " " ?c3 " " ?s1 crlf)
  (modify ?cS (p1 ?s2) (p2 ?s4) (p3 blank) (p4 ?s1))
  (pop-focus)
)
(defrule computer-stepN-1G-POS4 (declare (salience -12))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 blank) (p3 blank) (p4 ?c4&:(neq ?c4 blank)) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 ?s2&:(neq ?s2 blank)) (p3 ?s3&:(neq ?s3 blank)) (p4 blank) )
  =>
  (assert (guess (step ?n) (g ?s2 ?s3 ?s1 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s2 " " ?s3 " " ?s1 " " ?c4 crlf)
  (modify ?cS (p1 ?s2) (p2 ?s3) (p3 ?s1) (p4 blank))
  (pop-focus)
)

;  ------------------------- 2 RP -------------------------
(defrule computer-stepN-2G-POS1 (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 ?c2&:(neq ?c2 blank)) (p3 blank) (p4 blank) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 blank) (p2 blank) (p3 ?s3&:(neq ?s3 blank)) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (assert (guess (step ?n) (g ?c1 ?c2 ?s4 ?s3) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?c2 " " ?s4 " " ?s3 crlf)
  (modify ?cS (p1 blank) (p2 blank) (p3 ?s4) (p4 ?s3))
  (pop-focus)
)
(defrule computer-stepN-2G-POS2 (declare (salience -10))
  (status (step ?n) (mode computer))
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 blank) (p3 ?c3&:(neq ?c3 blank)) (p4 blank) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 blank) (p2 ?s2&:(neq ?s2 blank)) (p3 blank) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (assert (guess (step ?n) (g ?c1 ?s4 ?c3 ?s2) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?s4 " " ?c3 " " ?s2 crlf)
  (modify ?cS (p1 blank) (p2 ?s4) (p3 blank) (p4 ?s2))
  (pop-focus)
)
(defrule computer-stepN-2G-POS3 (declare (salience -11))
  (status (step ?n) (mode computer))
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 blank) (p3 blank) (p4 ?c4&:(neq ?c4 blank)) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 blank) (p2 ?s2&:(neq ?s2 blank)) (p3 ?s3&:(neq ?s3 blank)) (p4 blank))
  =>

  (assert (guess (step ?n) (g ?c1 ?s3 ?s2 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?s3 " " ?s2 " " ?c4 crlf)
  (modify ?cS (p1 blank) (p2 ?s3) (p3 ?s2) (p4 blank))
  (pop-focus)
)
(defrule computer-stepN-2G-POS4 (declare (salience -12))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 ?c2&:(neq ?c2 blank)) (p3 ?c3&:(neq ?c3 blank)) (p4 blank) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 blank) (p3 blank) (p4 ?s4&:(neq ?s4 blank)))
  =>
  (assert (guess (step ?n) (g ?s4 ?c2 ?c3 ?s1) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s4 " " ?c2 " " ?c3 " " ?s1 crlf)
  (modify ?cS (p1 ?s4) (p2 blank) (p3 blank) (p4 ?s1))
  (pop-focus)
)
(defrule computer-stepN-2G-POS5 (declare (salience -13))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 ?c2&:(neq ?c2 blank)) (p3 blank) (p4 ?c4&:(neq ?c4 blank)) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 blank) (p3 ?s3&:(neq ?s3 blank)) (p4 blank))
  =>
  (assert (guess (step ?n) (g ?s3 ?c2 ?s1 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?s3 " " ?c2 " " ?s1 " " ?c4 crlf)
  (modify ?cS (p1 ?s3) (p2 blank) (p3 ?s1) (p4 blank))
  (pop-focus)
)
(defrule computer-stepN-2G-POS6 (declare (salience -14))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 blank) (p3 ?c3&:(neq ?c3 blank)) (p4 ?c4&:(neq ?c4 blank)) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
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
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 ?c2&:(neq ?c2 blank)) (p3 ?c3&:(neq ?c3 blank)) (p4 blank) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 blank) (p2 blank) (p3 blank) (p4 ?s4&:(neq ?s4 blank)) (id ?idC) )
  =>
  (assert (guess (step ?n) (g ?c1 ?c2 ?c3 ?s4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?c2 " " ?c3 " " ?s4 crlf)
  ;(modify ?cS (p1 blank) (p2 blank) (p3 blank) (p4 ?s4))
  (pop-focus)
)
(defrule computer-stepN-3G-POS2 (declare (salience -10))
  (status (step ?n) (mode computer))
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 ?c2&:(neq ?c2 blank)) (p3 blank) (p4 ?c4&:(neq ?c4 blank)) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 blank) (p2 blank) (p3 ?s3&:(neq ?s3 blank)) (p4 blank) (id ?idC) )
  =>
  (assert (guess (step ?n) (g ?c1 ?c2 ?s3 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?c2 " " ?s3 " " ?c4 crlf)
  ;(modify ?cS (p1 blank) (p2 blank) (p3 ?s3) (p4 blank))
  (pop-focus)
)
(defrule computer-stepN-3G-POS3 (declare (salience -11))
  (status (step ?n) (mode computer))
  (code (p1 ?c1&:(neq ?c1 blank)) (p2 blank) (p3 ?c3&:(neq ?c3 blank)) (p4 ?c4&:(neq ?c4 blank)) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 blank) (p2 ?s2&:(neq ?s2 blank)) (p3 blank) (p4 blank) (id ?idC) )
  =>
  (assert (guess (step ?n) (g ?c1 ?s2 ?c3 ?c4) ))
  (printout t "La tua giocata allo step: " ?n " -> " ?c1 " " ?s2 " " ?c3 " " ?c4 crlf)
  ;(modify ?cS (p1 blank) (p2 ?s2) (p3 blank) (p4 blank))
  (pop-focus)
)
(defrule computer-stepN-3G-POS4 (declare (salience -12))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 ?c2&:(neq ?c2 blank)) (p3 ?c3&:(neq ?c3 blank)) (p4 ?c4&:(neq ?c4 blank)) (id ?idC))
  (not (code (id ?idC2&:(< ?idC2 ?idC))))
  ?cS <- (codeS (p1 ?s1&:(neq ?s1 blank)) (p2 blank) (p3 blank) (p4 blank) (id ?idC) )
  =>
  (assert (guess (step ?n) (g ?s1 ?c2 ?c3 ?c4) ))
  (printout t "ID utilizzato " ?idC crlf)

  (printout t "La tua giocata allo step: " ?n " -> " ?s1 " " ?c2 " " ?c3 " " ?c4 crlf)
  ;(modify ?cS (p1 blank) (p2 blank) (p3 blank) (p4 ?s4))
  (pop-focus)
)

(defrule computer-player-step-last (declare (salience -10))
  (maxduration ?x)
  (status (step ?s&:(= ?s (- ?x 1))) (mode computer))
  =>
  (printout t "Ultimo Girooo" crlf)
)


;  ---------------------------------------------
;  -------- Esame mossa / Cambio Valori --------
;  ---------------------------------------------

;---------------- 0 - 0 ---------------- 

(defrule step0N-0-0 (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step ?n) (g  ?c1 ?c2 ?c3 ?c4) )

  =>
  (printout t "Right placed " ?rp " missplaced "?mp crlf)
  
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  (assert (code (p1 blank) (p2 blank) (p3 blank) (p4 blank) (rp 0) (mp 4) (id ?n)))
  (do-for-fact ((?s1 color) (?s2 color) (?s3 color) (?s4 color)) 
    (and 
      (neq ?s1:name ?c1) (neq ?s1:name ?c2) (neq ?s1:name ?c3) (neq ?s1:name ?c4)
      (neq ?s2:name ?c1) (neq ?s2:name ?c2) (neq ?s2:name ?c3) (neq ?s2:name ?c4) (neq ?s2:name ?s1:name)
      (neq ?s3:name ?c1) (neq ?s3:name ?c2) (neq ?s3:name ?c3) (neq ?s3:name ?c4) (neq ?s3:name ?s2:name) (neq ?s3:name ?s1:name)
      (neq ?s4:name ?c1) (neq ?s4:name ?c2) (neq ?s4:name ?c3) (neq ?s4:name ?c4) (neq ?s4:name ?s3:name) (neq ?s4:name ?s2:name) (neq ?s4:name ?s1:name)
    )
    (assert (codeS (p1 ?s1:name) (p2 ?s2:name) (p3 ?s3:name) (p4 ?s4:name) (id ?n)))
  )

)

;---------------- 0 - Y ---------------- 
;SE MIGLIORE
(defrule 0-Y-Migliore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )

  (code (p1 ?c1) (p2 ?c2) (p3 ?c3) (p4 ?c4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (> (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (printout t "Right placed " ?rp " missplaced "?mp crlf)

  ;-------cancello tutto
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  ;-------assert questi code
  (assert (code (p1 blank) (p2 blank) (p3 blank) (p4 blank) (rp 0) (mp ?mp) (id ?n)))
  (assert (codeS (p1 ?g1) (p2 ?g2) (p3 ?g3) (p4 ?g4) (id ?n) ))
)
;SE PEGGIORE
(defrule 0-Y-Peggiore (declare (salience -8))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 0)) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )
  
  =>
  (printout t "Right placed " ?rp " missplaced "?mp crlf)

  ;(test (< (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  (do-for-fact  ((?var code)) 
    (< (+ (* ?rp 4) ?mp) (+ (* ?var:rp 4) ?var:mp)) 
    (and
      (do-for-fact  ((?varS codeS)) (eq ?varS:id ?var:id) (retract ?varS))
      (retract ?var)
    )
  )
  ;(do-for-fact  ((?var code)) 
    ;(= (+ (* ?rp 4) ?mp) (+ (* ?var:rp 4) ?var:mp)) 
    ;(and
      ;(printout t "-----------------------------------------" "Siamo in uguale Right placed " ?rp " missplaced " ?mp crlf)
      ;(printout t "------------------------------------------------------------------------------------------------" crlf)
    ;)
  ;)
  
)
;SE UGUALE
; non fai nulla

;---------------- X - 0 ---------------- 
;SE MIGLIORE
(defrule 1X-0-Migliore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 1)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )

  (code (p1 ?c1) (p2 ?c2) (p3 ?c3) (p4 ?c4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (> (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (printout t "Right placed " ?rp " missplaced "?mp crlf)
  
  ;-------cancello tutto
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  (assert (code (p1 ?g1) (p2 blank) (p3 blank) (p4 blank) (rp 1) (mp 0) (id ?n) ))
  (do-for-fact ((?s2 color) (?s3 color) (?s4 color)) 
    (and 
      (neq ?s2:name ?g1) (neq ?s2:name ?g2) (neq ?s2:name ?g3) (neq ?s2:name ?g4)
      (neq ?s3:name ?g1) (neq ?s3:name ?g2) (neq ?s3:name ?g3) (neq ?s3:name ?g4) (neq ?s3:name ?s2:name)
      (neq ?s4:name ?g1) (neq ?s4:name ?g2) (neq ?s4:name ?g3) (neq ?s4:name ?g4) (neq ?s4:name ?s3:name) (neq ?s4:name ?s2:name) 
    )
    (assert (codeS (p1 blank) (p2 ?s2:name) (p3 ?s3:name) (p4 ?s4:name) (id ?n) ))
  )

  (assert (code (p1 blank) (p2 ?g2) (p3 blank) (p4 blank) (rp 1) (mp 0) (id (+ ?n 100)) ))
  (do-for-fact ((?s1 color) (?s3 color) (?s4 color)) 
    (and 
      (neq ?s1:name ?g1) (neq ?s1:name ?g2) (neq ?s1:name ?g3) (neq ?s1:name ?g4)
      (neq ?s3:name ?g1) (neq ?s3:name ?g2) (neq ?s3:name ?g3) (neq ?s3:name ?g4) (neq ?s3:name ?s1:name)
      (neq ?s4:name ?g1) (neq ?s4:name ?g2) (neq ?s4:name ?g3) (neq ?s4:name ?g4) (neq ?s4:name ?s3:name) (neq ?s4:name ?s1:name) 
    )
    (assert (codeS (p1 ?s1:name) (p2 blank) (p3 ?s3:name) (p4 ?s4:name) (id (+ ?n 100)) ))
  )

  (assert (code (p1 blank) (p2 blank) (p3 ?g3) (p4 blank) (rp 1) (mp 0) (id (+ ?n 101)) ))
  (do-for-fact ((?s1 color) (?s2 color) (?s4 color)) 
    (and 
      (neq ?s1:name ?g1) (neq ?s1:name ?g2) (neq ?s1:name ?g3) (neq ?s1:name ?g4)
      (neq ?s2:name ?g1) (neq ?s2:name ?g2) (neq ?s2:name ?g3) (neq ?s2:name ?g4) (neq ?s2:name ?s1:name)
      (neq ?s4:name ?g1) (neq ?s4:name ?g2) (neq ?s4:name ?g3) (neq ?s4:name ?g4) (neq ?s4:name ?s2:name) (neq ?s4:name ?s1:name) 
    )
    (assert (codeS (p1 ?s1:name) (p2 ?s2:name) (p3 blank) (p4 ?s4:name) (id (+ ?n 101)) ))
  )

  (assert (code (p1 blank) (p2 blank) (p3 blank) (p4 ?g4) (rp 1) (mp 0) (id (+ ?n 102)) ))
  (do-for-fact ((?s1 color) (?s2 color) (?s3 color)) 
    (and 
      (neq ?s1:name ?g1) (neq ?s1:name ?g2) (neq ?s1:name ?g3) (neq ?s1:name ?g4)
      (neq ?s2:name ?g1) (neq ?s2:name ?g2) (neq ?s2:name ?g3) (neq ?s2:name ?g4) (neq ?s2:name ?s1:name)
      (neq ?s3:name ?g1) (neq ?s3:name ?g2) (neq ?s3:name ?g3) (neq ?s3:name ?g4) (neq ?s3:name ?s2:name) (neq ?s3:name ?s1:name) 
    )
    (assert (codeS (p1 ?s1:name) (p2 ?s2:name) (p3 ?s3:name) (p4 blank) (id (+ ?n 102)) ))
  )
)
(defrule 2X-0-Migliore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 2)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )

  (code (p1 ?c1) (p2 ?c2) (p3 ?c3) (p4 ?c4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (> (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (printout t "Right placed " ?rp " missplaced "?mp crlf)

  ;-------cancello tutto
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  (assert (code (p1 ?g1) (p2 ?g2) (p3 blank) (p4 blank) (rp 2) (mp 0) (id (+ ?n 100)) ))
  (assert (code (p1 ?g1) (p2 ?g2) (p3 blank) (p4 blank) (rp 2) (mp 0) (id (+ ?n 106)) ))
  (do-for-fact ((?s3_1 color) (?s4_1 color) (?s3_2 color) (?s4_2 color)) 
    (and 
      (neq ?s3_1:name ?g1) (neq ?s3_1:name ?g2) (neq ?s3_1:name ?g3) (neq ?s3_1:name ?g4)
      (neq ?s4_1:name ?g1) (neq ?s4_1:name ?g2) (neq ?s4_1:name ?g3) (neq ?s4_1:name ?g4) (neq ?s4_1:name ?s3_1:name)
      (neq ?s3_2:name ?g1) (neq ?s3_2:name ?g2) (neq ?s3_2:name ?g3) (neq ?s3_2:name ?g4) (neq ?s3_2:name ?s4_1:name) (neq ?s3_2:name ?s3_1:name)
      (neq ?s4_2:name ?g1) (neq ?s4_2:name ?g2) (neq ?s4_2:name ?g3) (neq ?s4_2:name ?g4) (neq ?s4_2:name ?s3_2:name) (neq ?s4_2:name ?s4_1:name) (neq ?s4_2:name ?s3_1:name)
    )
    (assert (codeS (p1 blank) (p2 blank) (p3 ?s3_1:name) (p4 ?s4_1:name) (id (+ ?n 100)) ))
    (assert (codeS (p1 blank) (p2 blank) (p3 ?s3_2:name) (p4 ?s4_2:name) (id (+ ?n 106)) ))
  )

  (assert (code (p1 ?g1) (p2 blank) (p3 ?g3) (p4 blank) (rp 2) (mp 0) (id (+ ?n 101)) ))
  (assert (code (p1 ?g1) (p2 blank) (p3 ?g3) (p4 blank) (rp 2) (mp 0) (id (+ ?n 107)) ))
  (do-for-fact ((?s2_1 color) (?s4_1 color) (?s2_2 color) (?s4_2 color))
    (and 
      (neq ?s2_1:name ?g1) (neq ?s2_1:name ?g2) (neq ?s2_1:name ?g3) (neq ?s2_1:name ?g4)
      (neq ?s4_1:name ?g1) (neq ?s4_1:name ?g2) (neq ?s4_1:name ?g3) (neq ?s4_1:name ?g4) (neq ?s4_1:name ?s2_1:name)
      (neq ?s2_2:name ?g1) (neq ?s2_2:name ?g2) (neq ?s2_2:name ?g3) (neq ?s2_2:name ?g4) (neq ?s2_2:name ?s4_1:name) (neq ?s2_2:name ?s2_1:name)
      (neq ?s4_2:name ?g1) (neq ?s4_2:name ?g2) (neq ?s4_2:name ?g3) (neq ?s4_2:name ?g4) (neq ?s4_2:name ?s2_2:name) (neq ?s4_2:name ?s4_1:name) (neq ?s4_2:name ?s2_1:name)
    )
    (assert (codeS (p1 blank) (p2 ?s2_1:name) (p3 blank) (p4 ?s4_1:name) (id (+ ?n 101)) ))
    (assert (codeS (p1 blank) (p2 ?s2_2:name) (p3 blank) (p4 ?s4_2:name) (id (+ ?n 107)) ))
  )

  (assert (code (p1 ?g1) (p2 blank) (p3 blank) (p4 ?g4) (rp 2) (mp 0) (id (+ ?n 102)) ))
  (assert (code (p1 ?g1) (p2 blank) (p3 blank) (p4 ?g4) (rp 2) (mp 0) (id (+ ?n 108)) ))
  (do-for-fact ((?s2_1 color) (?s3_1 color) (?s2_2 color) (?s3_2 color))
    (and 
      (neq ?s2_1:name ?g1) (neq ?s2_1:name ?g2) (neq ?s2_1:name ?g3) (neq ?s2_1:name ?g4)
      (neq ?s3_1:name ?g1) (neq ?s3_1:name ?g2) (neq ?s3_1:name ?g3) (neq ?s3_1:name ?g4) (neq ?s3_1:name ?s2_1:name)
      (neq ?s2_2:name ?g1) (neq ?s2_2:name ?g2) (neq ?s2_2:name ?g3) (neq ?s2_2:name ?g4) (neq ?s2_2:name ?s3_1:name) (neq ?s2_2:name ?s2_1:name)
      (neq ?s3_2:name ?g1) (neq ?s3_2:name ?g2) (neq ?s3_2:name ?g3) (neq ?s3_2:name ?g4) (neq ?s3_2:name ?s2_2:name) (neq ?s3_2:name ?s3_1:name) (neq ?s3_2:name ?s2_1:name)
    )
    (assert (codeS (p1 blank) (p2 ?s2_1:name) (p3 ?s3_1:name) (p4 blank) (id (+ ?n 102)) ))
    (assert (codeS (p1 blank) (p2 ?s2_2:name) (p3 ?s3_2:name) (p4 blank) (id (+ ?n 108)) ))
  )

  (assert (code (p1 blank) (p2 ?g2) (p3 ?g3) (p4 blank) (rp 2) (mp 0) (id (+ ?n 103)) ))
  (assert (code (p1 blank) (p2 ?g2) (p3 ?g3) (p4 blank) (rp 2) (mp 0) (id (+ ?n 109)) ))
  (do-for-fact ((?s1_1 color) (?s4_1 color) (?s1_2 color) (?s4_2 color))
    (and 
      (neq ?s1_1:name ?g1) (neq ?s1_1:name ?g2) (neq ?s1_1:name ?g3) (neq ?s1_1:name ?g4)
      (neq ?s4_1:name ?g1) (neq ?s4_1:name ?g2) (neq ?s4_1:name ?g3) (neq ?s4_1:name ?g4) (neq ?s4_1:name ?s1_1:name)
      (neq ?s1_2:name ?g1) (neq ?s1_2:name ?g2) (neq ?s1_2:name ?g3) (neq ?s1_2:name ?g4) (neq ?s1_2:name ?s4_1:name) (neq ?s1_2:name ?s1_1:name)
      (neq ?s4_2:name ?g1) (neq ?s4_2:name ?g2) (neq ?s4_2:name ?g3) (neq ?s4_2:name ?g4) (neq ?s4_2:name ?s1_2:name) (neq ?s4_2:name ?s4_1:name) (neq ?s4_2:name ?s1_1:name)
    )
    (assert (codeS (p1 ?s1_1:name) (p2 blank) (p3 blank) (p4 ?s4_1:name) (id (+ ?n 103)) ))
    (assert (codeS (p1 ?s1_2:name) (p2 blank) (p3 blank) (p4 ?s4_2:name) (id (+ ?n 109)) ))
    
  )

  (assert (code (p1 blank) (p2 ?g2) (p3 blank) (p4 ?g4) (rp 2) (mp 0) (id (+ ?n 104)) ))
  (assert (code (p1 blank) (p2 ?g2) (p3 blank) (p4 ?g4) (rp 2) (mp 0) (id (+ ?n 110)) ))
  (do-for-fact ((?s1_1 color) (?s3_1 color) (?s1_2 color) (?s3_2 color))
    (and 
      (neq ?s1_1:name ?g1) (neq ?s1_1:name ?g2) (neq ?s1_1:name ?g3) (neq ?s1_1:name ?g4)
      (neq ?s3_1:name ?g1) (neq ?s3_1:name ?g2) (neq ?s3_1:name ?g3) (neq ?s3_1:name ?g4) (neq ?s3_1:name ?s1_1:name)
      (neq ?s1_2:name ?g1) (neq ?s1_2:name ?g2) (neq ?s1_2:name ?g3) (neq ?s1_2:name ?g4) (neq ?s1_2:name ?s3_1:name) (neq ?s1_2:name ?s1_1:name)
      (neq ?s3_2:name ?g1) (neq ?s3_2:name ?g2) (neq ?s3_2:name ?g3) (neq ?s3_2:name ?g4) (neq ?s3_2:name ?s1_2:name) (neq ?s3_2:name ?s3_1:name) (neq ?s3_2:name ?s1_1:name)
    )
    (assert (codeS (p1 ?s1_1:name) (p2 blank) (p3 ?s3_1:name) (p4 blank) (id (+ ?n 104)) ))
    (assert (codeS (p1 ?s1_2:name) (p2 blank) (p3 ?s3_2:name) (p4 blank) (id (+ ?n 110)) ))
  )

  (assert (code (p1 blank) (p2 blank) (p3 ?g3) (p4 ?g4) (rp 2) (mp 0) (id (+ ?n 105)) ))
  (assert (code (p1 blank) (p2 blank) (p3 ?g3) (p4 ?g4) (rp 2) (mp 0) (id (+ ?n 111)) ))
  (do-for-fact ((?s1_1 color) (?s2_1 color) (?s1_2 color) (?s2_2 color))
    (and 
      (neq ?s1_1:name ?g1) (neq ?s1_1:name ?g2) (neq ?s1_1:name ?g3) (neq ?s1_1:name ?g4)
      (neq ?s2_1:name ?g1) (neq ?s2_1:name ?g2) (neq ?s2_1:name ?g3) (neq ?s2_1:name ?g4) (neq ?s2_1:name ?s1_1:name)
      (neq ?s1_2:name ?g1) (neq ?s1_2:name ?g2) (neq ?s1_2:name ?g3) (neq ?s1_2:name ?g4) (neq ?s1_2:name ?s2_1:name) (neq ?s1_2:name ?s1_1:name)
      (neq ?s2_2:name ?g1) (neq ?s2_2:name ?g2) (neq ?s2_2:name ?g3) (neq ?s2_2:name ?g4) (neq ?s2_2:name ?s1_2:name) (neq ?s2_2:name ?s2_1:name) (neq ?s2_2:name ?s1_1:name)
    )
    (assert (codeS (p1 ?s1_1:name) (p2 ?s2_1:name) (p3 blank) (p4 blank) (id (+ ?n 105)) ))
    (assert (codeS (p1 ?s1_2:name) (p2 ?s2_2:name) (p3 blank) (p4 blank) (id (+ ?n 111)) ))
  )
)
(defrule 3X-0-Migliore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 3)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )

  (code (p1 ?c1) (p2 ?c2) (p3 ?c3) (p4 ?c4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (> (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (printout t "Right placed " ?rp " missplaced "?mp crlf)

  ;-------cancello tutto
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  (assert (code (p1 ?g1) (p2 ?g2) (p3 ?g3) (p4 blank) (rp 3) (mp 0) (id (+ ?n 100)) ))
  (assert (code (p1 ?g1) (p2 ?g2) (p3 ?g3) (p4 blank) (rp 3) (mp 0) (id (+ ?n 101)) ))
  (assert (code (p1 ?g1) (p2 ?g2) (p3 ?g3) (p4 blank) (rp 3) (mp 0) (id (+ ?n 102)) ))
  (assert (code (p1 ?g1) (p2 ?g2) (p3 ?g3) (p4 blank) (rp 3) (mp 0) (id (+ ?n 103)) ))
  (do-for-fact ((?s4_1 color) (?s4_2 color) (?s4_3 color) (?s4_4 color)) 
    (and 
      (neq ?s4_1:name ?g1) (neq ?s4_1:name ?g2) (neq ?s4_1:name ?g3) (neq ?s4_1:name ?g4)
      (neq ?s4_2:name ?g1) (neq ?s4_2:name ?g2) (neq ?s4_2:name ?g3) (neq ?s4_2:name ?g4) (neq ?s4_2:name ?s4_1:name)
      (neq ?s4_3:name ?g1) (neq ?s4_3:name ?g2) (neq ?s4_3:name ?g3) (neq ?s4_3:name ?g4) (neq ?s4_3:name ?s4_2:name) (neq ?s4_3:name ?s4_1:name)
      (neq ?s4_4:name ?g1) (neq ?s4_4:name ?g2) (neq ?s4_4:name ?g3) (neq ?s4_4:name ?g4) (neq ?s4_4:name ?s4_3:name) (neq ?s4_4:name ?s4_2:name) (neq ?s4_4:name ?s4_1:name)
    )
    (assert (codeS (p1 blank) (p2 blank) (p3 blank) (p4 ?s4_1:name) (id (+ ?n 100)) ))
    (assert (codeS (p1 blank) (p2 blank) (p3 blank) (p4 ?s4_2:name) (id (+ ?n 101)) ))
    (assert (codeS (p1 blank) (p2 blank) (p3 blank) (p4 ?s4_3:name) (id (+ ?n 102)) ))
    (assert (codeS (p1 blank) (p2 blank) (p3 blank) (p4 ?s4_4:name) (id (+ ?n 103)) ))
  )

  (assert (code (p1 ?g1) (p2 ?g2) (p3 blank) (p4 ?g4) (rp 3) (mp 0) (id (+ ?n 104)) ))
  (assert (code (p1 ?g1) (p2 ?g2) (p3 blank) (p4 ?g4) (rp 3) (mp 0) (id (+ ?n 105)) ))
  (assert (code (p1 ?g1) (p2 ?g2) (p3 blank) (p4 ?g4) (rp 3) (mp 0) (id (+ ?n 106)) ))
  (assert (code (p1 ?g1) (p2 ?g2) (p3 blank) (p4 ?g4) (rp 3) (mp 0) (id (+ ?n 107)) ))

  (do-for-fact ((?s3_1 color) (?s3_2 color) (?s3_3 color) (?s3_4 color)) 
    (and 
      (neq ?s3_1:name ?g1) (neq ?s3_1:name ?g2) (neq ?s3_1:name ?g3) (neq ?s3_1:name ?g4)
      (neq ?s3_2:name ?g1) (neq ?s3_2:name ?g2) (neq ?s3_2:name ?g3) (neq ?s3_2:name ?g4) (neq ?s3_2:name ?s3_1:name)
      (neq ?s3_3:name ?g1) (neq ?s3_3:name ?g2) (neq ?s3_3:name ?g3) (neq ?s3_3:name ?g4) (neq ?s3_3:name ?s3_2:name) (neq ?s3_3:name ?s3_1:name)
      (neq ?s3_4:name ?g1) (neq ?s3_4:name ?g2) (neq ?s3_4:name ?g3) (neq ?s3_4:name ?g4) (neq ?s3_4:name ?s3_3:name) (neq ?s3_4:name ?s3_2:name) (neq ?s3_4:name ?s3_1:name)
    )
    (assert (codeS (p1 blank) (p2 blank) (p3 ?s3_1:name) (p4 blank) (id (+ ?n 104)) ))
    (assert (codeS (p1 blank) (p2 blank) (p3 ?s3_2:name) (p4 blank) (id (+ ?n 105)) ))
    (assert (codeS (p1 blank) (p2 blank) (p3 ?s3_3:name) (p4 blank) (id (+ ?n 106)) ))
    (assert (codeS (p1 blank) (p2 blank) (p3 ?s3_4:name) (p4 blank) (id (+ ?n 107)) ))
  )

  (assert (code (p1 ?g1) (p2 blank) (p3 ?g3) (p4 ?g4) (rp 3) (mp 0) (id (+ ?n 108)) ))
  (assert (code (p1 ?g1) (p2 blank) (p3 ?g3) (p4 ?g4) (rp 3) (mp 0) (id (+ ?n 109)) ))
  (assert (code (p1 ?g1) (p2 blank) (p3 ?g3) (p4 ?g4) (rp 3) (mp 0) (id (+ ?n 110)) ))
  (assert (code (p1 ?g1) (p2 blank) (p3 ?g3) (p4 ?g4) (rp 3) (mp 0) (id (+ ?n 111)) ))
  (do-for-fact ((?s2_1 color) (?s2_2 color) (?s2_3 color) (?s2_4 color))
    (and 
      (neq ?s2_1:name ?g1) (neq ?s2_1:name ?g2) (neq ?s2_1:name ?g3) (neq ?s2_1:name ?g4)
      (neq ?s2_2:name ?g1) (neq ?s2_2:name ?g2) (neq ?s2_2:name ?g3) (neq ?s2_2:name ?g4) (neq ?s2_2:name ?s2_1:name)
      (neq ?s2_3:name ?g1) (neq ?s2_3:name ?g2) (neq ?s2_3:name ?g3) (neq ?s2_3:name ?g4) (neq ?s2_3:name ?s2_2:name) (neq ?s2_3:name ?s2_1:name)
      (neq ?s2_4:name ?g1) (neq ?s2_4:name ?g2) (neq ?s2_4:name ?g3) (neq ?s2_4:name ?g4) (neq ?s2_4:name ?s2_3:name) (neq ?s2_4:name ?s2_2:name) (neq ?s2_4:name ?s2_1:name)
    )
    (assert (codeS (p1 blank) (p2 ?s2_1:name) (p3 blank) (p4 blank) (id (+ ?n 108)) ))
    (assert (codeS (p1 blank) (p2 ?s2_2:name) (p3 blank) (p4 blank) (id (+ ?n 109)) ))
    (assert (codeS (p1 blank) (p2 ?s2_3:name) (p3 blank) (p4 blank) (id (+ ?n 110)) ))
    (assert (codeS (p1 blank) (p2 ?s2_4:name) (p3 blank) (p4 blank) (id (+ ?n 111)) ))
  )

  (assert (code (p1 blank) (p2 ?g2) (p3 ?g3) (p4 ?g4) (rp 3) (mp 0) (id (+ ?n 112)) ))
  (assert (code (p1 blank) (p2 ?g2) (p3 ?g3) (p4 ?g4) (rp 3) (mp 0) (id (+ ?n 113)) ))
  (assert (code (p1 blank) (p2 ?g2) (p3 ?g3) (p4 ?g4) (rp 3) (mp 0) (id (+ ?n 114)) ))
  (assert (code (p1 blank) (p2 ?g2) (p3 ?g3) (p4 ?g4) (rp 3) (mp 0) (id (+ ?n 115)) ))
  (do-for-fact ((?s1_1 color) (?s1_2 color) (?s1_3 color) (?s1_4 color)) 
    (and 
      (neq ?s1_1:name ?g1) (neq ?s1_1:name ?g2) (neq ?s1_1:name ?g3) (neq ?s1_1:name ?g4)
      (neq ?s1_2:name ?g1) (neq ?s1_2:name ?g2) (neq ?s1_2:name ?g3) (neq ?s1_2:name ?g4) (neq ?s1_2:name ?s1_1:name)
      (neq ?s1_3:name ?g1) (neq ?s1_3:name ?g2) (neq ?s1_3:name ?g3) (neq ?s1_3:name ?g4) (neq ?s1_3:name ?s1_2:name) (neq ?s1_3:name ?s1_1:name)
      (neq ?s1_4:name ?g1) (neq ?s1_4:name ?g2) (neq ?s1_4:name ?g3) (neq ?s1_4:name ?g4) (neq ?s1_4:name ?s1_3:name) (neq ?s1_4:name ?s1_2:name) (neq ?s1_4:name ?s1_1:name)
    )
    (assert (codeS (p1 ?s1_1:name) (p2 blank) (p3 blank) (p4 blank) (id (+ ?n 112)) ))
    (assert (codeS (p1 ?s1_2:name) (p2 blank) (p3 blank) (p4 blank) (id (+ ?n 113)) ))
    (assert (codeS (p1 ?s1_3:name) (p2 blank) (p3 blank) (p4 blank) (id (+ ?n 114)) ))
    (assert (codeS (p1 ?s1_4:name) (p2 blank) (p3 blank) (p4 blank) (id (+ ?n 115)) ))
  )
)
;SE PEGGIORE o SE UGUALE
(defrule X-0-Peggiore (declare (salience -6))
  (answer (step ?n) (right-placed ?rp&:(> ?rp 0)) (miss-placed ?mp&:(= ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )
  =>
  (printout t "Right placed " ?rp " missplaced "?mp crlf)

  ;(test (< (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))

  ;se peggiore
  (do-for-fact  ((?var code)) 
    (< (+ (* ?rp 4) ?mp) (+ (* ?var:rp 4) ?var:mp))
    (and
      (do-for-fact  ((?varS codeS)) (eq ?varS:id ?var:id) (retract ?varS))
      (retract ?var)
    )
  )

  ;se uguale
  (do-for-fact  ((?var code)) 
    (and
      (>= ?rp 2)
      (= (+ (* ?rp 4) ?mp) (+ (* ?var:rp 4) ?var:mp))
      ;(not (code (id ?idC2&:(< ?idC2 ?var:idC))))
    )
    (and
      (do-for-fact  ((?varS codeS)) (eq ?varS:id ?var:id) (retract ?varS))
      (retract ?var)
    )
  )

)

;---------------- X - Y ---------------- 
;SE MIGLIORE
(defrule 1X-Y-Migliore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 1)) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?c1 ?c2 ?c3 ?c4) )

  (code (p1 ?z1) (p2 ?z2) (p3 ?z3) (p4 ?z4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (> (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (printout t "Right placed " ?rp " missplaced "?mp crlf)

  ;-------cancello tutto
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  (assert (code (p1 ?c1) (p2 blank) (p3 blank) (p4 blank) (rp 1) (mp ?mp) (id ?n)))
  (assert (codeS (p1 blank) (p2 ?c2) (p3 ?c3) (p4 ?c4) (id ?n) ))

  (assert (code (p1 blank) (p2 ?c2) (p3 blank) (p4 blank) (rp 1) (mp ?mp) (id (+ ?n 100)) ))
  (assert (codeS (p1 ?c1) (p2 blank) (p3 ?c3) (p4 ?c4) (id (+ ?n 100)) ))

  (assert (code (p1 blank) (p2 blank) (p3 ?c3) (p4 blank) (rp 1) (mp ?mp) (id (+ ?n 101)) ))
  (assert (codeS (p1 ?c1) (p2 ?c2) (p3 blank) (p4 ?c4) (id (+ ?n 101)) ))

  (assert (code (p1 blank) (p2 blank) (p3 blank) (p4 ?c4) (rp 1) (mp ?mp) (id (+ ?n 102)) ))
  (assert (codeS (p1 ?c1) (p2 ?c2) (p3 ?c3) (p4 blank) (id (+ ?n 102)) ))

)
(defrule 2X-Y-Migliore (declare (salience -7))
  (answer (step ?n) (right-placed ?rp&:(= ?rp 2)) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?c1 ?c2 ?c3 ?c4) )

  (code (p1 ?z1) (p2 ?z2) (p3 ?z3) (p4 ?z4) (rp ?rpO) (mp ?mpO))
  (codeS (p1 ?s1) (p2 ?s2) (p3 ?s3) (p4 ?s4))
  (test (> (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  =>
  (printout t "Right placed " ?rp " missplaced "?mp crlf)

  ;-------cancello tutto
  (do-for-all-facts  ((?var code)) TRUE (retract ?var))
  (do-for-all-facts  ((?var codeS)) TRUE (retract ?var))

  (assert (code (p1 ?c1) (p2 ?c2) (p3 blank) (p4 blank) (rp 2) (mp ?mp) (id ?n) )) 
  (assert (codeS (p1 blank) (p2 blank) (p3 ?c3) (p4 ?c4) (id ?n) ))

  (assert (code (p1 ?c1) (p2 blank) (p3 ?c3) (p4 blank) (rp 2) (mp ?mp) (id (+ ?n 100)) ))
  (assert (codeS (p1 blank) (p2 ?c2) (p3 blank) (p4 ?c4) (id (+ ?n 100)) ))

  (assert (code (p1 ?c1) (p2 blank) (p3 blank) (p4 ?c4) (rp 2) (mp ?mp) (id (+ ?n 101)) ))
  (assert (codeS (p1 blank) (p2 ?c2) (p3 ?c3) (p4 blank) (id (+ ?n 101)) ))

  (assert (code (p1 blank) (p2 ?c2) (p3 ?c3) (p4 blank) (rp 2) (mp ?mp) (id (+ ?n 102)) ))
  (assert (codeS (p1 ?c1) (p2 blank) (p3 blank) (p4 ?c4) (id (+ ?n 102)) ))

  (assert (code (p1 blank) (p2 ?c2) (p3 blank) (p4 ?c4) (rp 2) (mp ?mp) (id (+ ?n 103)) ))
  (assert (codeS (p1 ?c1) (p2 blank) (p3 ?c3) (p4 blank) (id (+ ?n 103)) ))

  (assert (code (p1 blank) (p2 blank) (p3 ?c3) (p4 ?c4) (rp 2) (mp ?mp) (id (+ ?n 104)) ))
  (assert (codeS (p1 ?c1) (p2 ?c2) (p3 blank) (p4 blank) (id (+ ?n 104)) ))

)
;SE PEGGIORE
(defrule X-Y-Peggiore (declare (salience -8))
  (answer (step ?n) (right-placed ?rp&:(> ?rp 0)) (miss-placed ?mp&:(> ?mp 0)))
  (guess (step ?n) (g  ?g1 ?g2 ?g3 ?g4) )
  =>
  (printout t "Right placed " ?rp " missplaced "?mp crlf)

  ;(test (< (+ (* ?rp 4) ?mp) (+ (* ?rpO 4) ?mpO)))
  (do-for-fact  ((?var code)) 
    (< (+ (* ?rp 4) ?mp) (+ (* ?var:rp 4) ?var:mp))
    (and
      (do-for-fact  ((?varS codeS)) (eq ?varS:id ?var:id) (retract ?varS))
      (retract ?var)
    ) 
  )
  
  ;(do-for-fact  ((?var code)) 
    ;(= (+ (* ?rp 4) ?mp) (+ (* ?var:rp 4) ?var:mp))
    ;(and
      ;(printout t "Siamo in UGUALE Right placed " ?rp " missplaced " ?mp crlf)
      ;(printout t "-" crlf)
    ;) 
  ;)

)
;SE UGUALE
; non fai nulla