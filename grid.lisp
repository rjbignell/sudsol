
(defclass sdk-grid ()
  ((board :initform (make-array '(9 9) :initial-element 0))
   (board-display :initform (make-array '(27 27) :initial-element ".")))
  (:documentation "A sudoku grid."))

(defmethod sdk-grid-cell (r c)
  "Get or set the cell."
  pass)

(defmethod sdk-grid-row (r)
  "Get the specified row."
  pass)

(defmethod sdk-grid-col (c)
  "Get the specific column."
  pass)

(defmethod sdk-grid-qdr-of (r c)
  "Get the quadrant of a cell."
  pass)

;; given row and column number the base of the 3x3 character cell is 3r,3c
;; 3r+0,3c+0 3r+0,3c+1, 3r+0,3c+2
;; 3r+1,3c+0 3r+1,3c+1, 3r+1,3c+2
;; 3r+2,3c+0 3r+2,3c+1, 3r+2,3c+2
;; for an unknown cell (only at the start) set all 9 to "."
;; for a single value set all 9 to "." and put the number in 3r+1,3c+1
;; for a set of values set all to "." then working in 3s write the number
;; into the cells

(defmethod sdk-grid-init-from-array (anarray array)
  "Return a grid initialised from the array in r,c order."
  pass)

(defmethod sdk-grid-init-from-user ()
  "Read a grid from the user and return it as a grid."
  pass)

(defmethod sdk-grid-display (agrid sdk-grid)
  "Display prettily the grid specified."
  pass)


