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

(defrule computer-player (declare (salience 1))
  (status (step ?s) (mode computer))
  =>
  (printout t "Your guess as computer at step " ?s crlf)
  (bind $?input (readline))
  (assert (guess (step ?s) (g  (explode$ $?input)) ))
  (pop-focus)
)

(defrule stampa (declare (salience 2))
  (answer (step ?s) (right-placed ?rp) (miss-placed ?mp)) 
  (status (step ?SS&:(eq ?s-1)) (mode computer))

  =>
  (printout t "Right aaaaaaaaaaa placed " ?rp " missplaced " ?mp crlf)
)


