
;;; define a package for our code
(defpackage #:sudsol
  (:use :cl))

;;; set context to our package (may need doing in the repl)
(in-package #:sudsol)

;;
;; make-array and aref....

(defvar *grid* nil)
(defvar *complete-grid* nil)
(defvar *one-cell-missing* nil)
(defvar *two-cells-missing* nil)
(defvar *more-cells-missing* nil)

(setf *complete-grid*
      #2A((1 4 7 2 5 8 3 6 9)
	  (2 5 8 3 6 9 4 7 1)
	  (3 6 9 4 7 1 5 8 2)
	  (4 7 1 5 8 2 6 9 3)
	  (5 8 2 6 9 3 7 1 4)
	  (6 9 3 7 1 4 8 2 5)
	  (7 1 4 8 2 5 9 3 6)
	  (8 2 5 9 3 6 1 4 7)
	  (9 3 6 1 4 7 2 5 8)))

(setf *one-cell-missing*
      #2A((1 4 7 2 5 8 3 6 9)
	  (2 5 8 3 6 9 4 7 1)
	  (3 6 9 4 7 1 5 8 2)
	  (4 7 1 5 8 2 6 9 3)
	  (5 8 2 6 0 3 7 1 4)
	  (6 9 3 7 1 4 8 2 5)
	  (7 1 4 8 2 5 9 3 6)
	  (8 2 5 9 3 6 1 4 7)
	  (9 3 6 1 4 7 2 5 8)))

(setf *two-cells-missing*
      #2A((1 4 7 2 5 8 3 6 9)
	  (2 5 8 3 6 9 4 7 1)
	  (3 6 9 4 7 1 5 8 2)
	  (4 7 1 5 8 2 6 9 3)
	  (5 8 2 6 9 3 7 1 4)
	  (6 9 3 7 1 4 8 2 5)
	  (7 1 4 8 2 5 9 3 6)
	  (8 2 5 9 3 6 1 4 7)
	  (9 3 6 1 4 7 2 5 8)))

(setf *more-cells-missing*
      #2A((1 4 7 2 5 8 3 6 9)
	  (2 5 8 3 6 9 4 7 1)
	  (3 6 9 4 7 1 5 8 2)
	  (4 7 1 5 8 2 6 9 3)
	  (5 8 2 6 9 3 7 1 4)
	  (6 9 3 7 1 4 8 2 5)
	  (7 1 4 8 2 5 9 3 6)
	  (8 2 5 9 3 6 1 4 7)
	  (9 3 6 1 4 7 2 5 8)))

(defun preset-grid ()
  (preset-grid-with *one-cell-missing*))

(defun preset-grid-with (sample)
  (setf *grid* sample)
  (dotimes (c 9)
    (dotimes (r 9)
      (if (zerop (aref *grid* r c))
	  (setf (aref *grid* r c) '(1 2 3 4 5 6 7 8 9))))))

(defun read-grid ()
  (let ((line nil))
    (setf *grid* (make-array '(9 9) :initial-element nil))
    (dotimes (c 9)
      (format t "Line ~A: " (+ c 1))
      (setf line (read))
      ;(format t "~A~%" line)
      (dotimes (r 9)
	(let ((v (nth r line)))
	  (format t "~A " v)
	  (setf (aref *grid* r c) (if (zerop v)
				       '(1 2 3 4 5 6 7 8 9)
				       v)))))))

(defun print-grid ()
  (dotimes (r 9)
    (dotimes (c 9)
      (format t "~A " (aref *grid* r c)))
    (format t "~%")))

(defun update-one-cell (r c)
  ;; a list is used to contain all the possible values
  ;; get the row, column, and quadrant known values
  ;; delete those from the current set of possibles
  (let* ((row-known (grid-row r))
	 (col-known (grid-column c))
	 (qdr-known (grid-quadrant-of-cell r c))
	 (all-known (union row-known (union col-known qdr-known)))
	 (options (set-difference (aref *grid* r c) all-known)))
    (if (eq 1 (length options))
	(setf (aref *grid* r c) (car options))
	(setf (aref *grid* r c) options))))
	  

(defun one-solve-pass ()
  (let ((thingstodo t))
    (dotimes (r 9)
      (dotimes (c 9)
	(unless (numberp (aref *grid* r c))
	  ;; a number is a known so can be skipped
	  (update-one-cell r c))))))

(defun solve ()
  (loop))

(defun grid-row (r)
  "return the numbered row as a list, of KNOWN values"
  (let ((result nil)
	(val nil))
    (dotimes (c 9)
      ;; count backwards coz we push
      (setf val (aref *grid* r (- 8 c)))
      (if (numberp val)
	  (push val result)))
    result))

(defun grid-column (c)
  "return the numbered column as a list, of KNOWN values"
  (let ((result nil)
	(val nil))
    (dotimes (r 9)
      ;; count backwards coz we push
      (setf val (aref *grid* (- 8 r) c))
      (if (numberp val)
	  (push val result)))
    result))

(defun grid-quadrant (qr qc)
  "return the indexed quadrant as a list, index = 0,1,2, of KNOWN values"
  (let ((result nil)
	(val nil))
    (dotimes (r 3)
      (dotimes (c 3)
	(setf val (aref *grid* (+ (* qr 3) r) (+ (* qc 3) c)))
	(if (numberp val)
	    (push val result))))
    (reverse result)))

(defun grid-quadrant-of-cell (r c)
  "return the quadrant containing r,c as a list, of KNOWN values"
  (let ((qr (floor (/ r 3)))
	(qc (floor (/ c 3))))
    (grid-quadrant qr qc)))

