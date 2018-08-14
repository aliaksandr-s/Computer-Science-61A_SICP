#lang racket/base

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1))) 

; a
(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-bottom
	   ((transform-painter
			      (make-vect 0.0 0.0)
			      (make-vect 1.0 0.0)
            split-point) painter1))
	  (paint-top
	   ((transform-painter
			      split-point
			      (make-vect 1.0 0.5)
			      (make-vect 0.0 1.0)) painter2)))
      (lambda (frame)
	(paint-bottom frame)
	(paint-top frame)))))

(paint (below einstein einstein))

; b
(define (below-2 painter1 painter2)
  (rotate-90 (beside (rotate-270 painter1) (rotate-270 painter2))))

(paint (below-2 einstein einstein))