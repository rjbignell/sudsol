;
; make-array and aref....


(defvar *board* nil)

(defun init-board ()
  (dotimes (x 9)
    (dotimes (y 9)
      (push (list :x (- 9 x) :y (- 9 y) :val nil :possibles nil) *board*))))

(setf *complete-board*
      #2A((1 4 7 2 5 8 3 6 9)
	  (2 5 8 3 6 9 4 7 1)
	  (3 6 9 4 7 1 5 8 2)
	  (4 7 1 5 8 4 6 9 3)
	  (5 8 2 6 9 5 7 1 4)
	  (6 9 3 7 1 6 8 2 5)
	  (7 1 4 8 2 7 9 3 6)
	  (8 2 5 9 3 8 1 4 7)
	  (9 3 6 1 4 9 2 5 8)))

(defun preset-board ()
  (setf *board*
	#2A((0 4 7 2 5 8 3 6 9)
	    (2 5 8 3 6 9 4 7 1)
	    (3 6 9 4 7 1 5 8 2)
	    (4 7 1 5 8 4 6 9 3)
	    (5 8 2 6 9 5 7 1 4)
	    (6 9 3 7 1 6 8 2 5)
	    (7 1 4 8 2 7 9 3 6)
	    (8 2 5 9 3 8 1 4 7)
	    (9 3 6 1 4 9 2 5 8)))
  (dotimes (y 9)
    (dotimes (x 9)
      (if (zerop (aref *board* x y))
	  (setf (aref *board* x y) (list 'u '(1 2 3 4 5 6 7 8 9)))))))

(defun x1 ()
  (dotimes (y 9)
    (dotimes (x 9)
      (unless (numberp (aref *board* x y))
	;get row, delete each element from possibles
	;get column, delete each element from possibles
	;get quadrant, delete each element from possibles
))))

(defun read-board ()
  (let ((line nil))
    (setf *board* (make-array '(9 9) :initial-element nil))
    (dotimes (y 9)
      (format t "Line ~A: " (+ y 1))
      (setf line (read))
      ;(format t "~A~%" line)
      (dotimes (x 9)
	(let ((v (nth x line)))
	  (format t "~A " v)
	  (setf (aref *board* x y) (if (zerop v)
				       (list 'u '(1 2 3 4 5 6 7 8 9))
				     v)))))))

(defun print-board ()
  (dotimes (y 9)
    (dotimes (x 9)
      (format t "~A " (aref *board* x y)))
    (format t "~%")))

(defun board-column (x)
  "return the numbered column as a list"
  (let ((result nil))
    (dotimes (y 9)
      ;; count backwards coz we push
      (push (aref *board* x (- 8 y)) result))
    result))

(defun board-row (y)
  "return the numbered row as a list"
  (let ((result nil))
    (dotimes (x 9)
      ;; count backwards coz we push
      (push (aref *board* (- 8 x) y) result))
    result))

(defun board-quadrant (qx qy)
  "return the indexed quadrant as a list, index = 0,1,2"
  (let ((result nil))
    (dotimes (x 3)
      (dotimes (y 3)
	(push (aref *board* (+ (* qx 3) x) (+ (* qy 3) y)) result)))
    (reverse result)))

(defun board-quadrant-of-cell (x y)
  "return the quadrant containing x,y as a list"
  (let ((qx 1)
	(qy 1))
    (board-quadrant qx qy)))

(defun quadrant-x-index-of (x y)
  "return the qx value for (x y)"
  nil)
