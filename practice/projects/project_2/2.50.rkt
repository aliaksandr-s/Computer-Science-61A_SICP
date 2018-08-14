#lang racket/base

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1))) 

(define flip-horiz
  (transform-painter 
    (make-vect 1.0 0.0)
		(make-vect 0.0 0.0)
		(make-vect 1.0 1.0)))

(define rotate180
  (transform-painter 
    (make-vect 1.0 1.0)
		(make-vect 0.0 1.0)
		(make-vect 1.0 0.0)))

(define rotate270
  (transform-painter 
    (make-vect 0.0 1.0)
		(make-vect 0.0 0.0)
		(make-vect 1.0 1.0)))

(paint einstein)
(paint (flip-horiz einstein))
(paint (rotate180 einstein))
(paint (rotate270 einstein))