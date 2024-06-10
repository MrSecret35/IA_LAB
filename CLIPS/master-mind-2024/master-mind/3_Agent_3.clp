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

;  ---------------------------------------------
;  ------------ Scelta della mossa -------------
;  ---------------------------------------------

(defrule computer-player-step-0 (declare (salience -9))
  (status (step 0) (mode computer))
  =>
  (bind ?l (length (find-all-facts ((?var code)) TRUE)))
  (printout t "mosse rimanenti  " ?l crlf)

  (assert (guess (step 0) (g blue red yellow green) ))
  (assert (code (p1 blank) (p2 blank) (p3 blank) (p4 blank) (rp 0) (mp 0)))
  (printout t "La tua giocata allo step: 0 -> blue red yellow green"crlf)
  (pop-focus)
)
(defrule computer-player-step-4B (declare (salience -9))
  (status (step ?n) (mode computer))
  (code (p1 blank) (p2 blank) (p3 blank) (p4 blank) (rp 0) (mp 0))
  (guess (step ?s&:(= ?s (- ?n 1))) (g  ?c1 ?c2 ?c3 ?c4))
  =>
  (bind ?l (length (find-all-facts ((?var code)) TRUE)))
  (printout t "mosse rimanenti  " ?l crlf)
  (assert (guess (step ?n) (g ?c2 ?c3 ?c4 ?c1) ))
  (printout t "La tua giocata allo step: " ?s " -> " ?c1 " " ?c2 " " ?c3 " " ?c4 crlf)
  (pop-focus)
)



;  ---------------------------------------------
;  -------- Esame mossa / Cambio Valori --------
;  ---------------------------------------------
