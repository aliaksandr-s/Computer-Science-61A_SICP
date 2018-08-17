#lang racket/base

(require rackunit)
(require (planet soegaard/sicp:2:1/sicp))

;a
(define wave-segments
  (list
    (make-segment
      (make-vect 0.006 0.840)
      (make-vect 0.155 0.591))
    (make-segment
      (make-vect 0.006 0.635)
      (make-vect 0.155 0.392))
    (make-segment
      (make-vect 0.304 0.646)
      (make-vect 0.155 0.591))
    (make-segment
      (make-vect 0.298 0.591)
      (make-vect 0.155 0.392))
    (make-segment
      (make-vect 0.304 0.646)
      (make-vect 0.403 0.646))
    (make-segment
      (make-vect 0.298 0.591)
      (make-vect 0.354 0.492))
    (make-segment
      (make-vect 0.403 0.646)
      (make-vect 0.348 0.845))
    (make-segment
      (make-vect 0.354 0.492)
      (make-vect 0.249 0.000))
    (make-segment
      (make-vect 0.403 0.000)
      (make-vect 0.502 0.293))
    (make-segment
      (make-vect 0.502 0.293)
      (make-vect 0.602 0.000))
    (make-segment
      (make-vect 0.348 0.845)
      (make-vect 0.403 0.999))
    (make-segment
      (make-vect 0.602 0.999)
      (make-vect 0.652 0.845))
    (make-segment
      (make-vect 0.652 0.845)
      (make-vect 0.602 0.646))
    (make-segment
      (make-vect 0.602 0.646)
      (make-vect 0.751 0.646))
    (make-segment
      (make-vect 0.751 0.646)
      (make-vect 0.999 0.343))
    (make-segment
      (make-vect 0.751 0.000)
      (make-vect 0.597 0.442))
    (make-segment
      (make-vect 0.597 0.442)
      (make-vect 0.999 0.144))
    (make-segment
      (make-vect 0.45 0.75)
      (make-vect 0.5 0.7))
    (make-segment
      (make-vect 0.5 0.7)
      (make-vect 0.55 0.7))))

(define wave (segments->painter wave-segments))
(paint wave)

;b
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
	(beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
	(below painter (beside smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
	    (right (right-split painter (- n 1)))
            (corner (corner-split painter (- n 1))))
	  (beside (below painter up)
		  (below right corner)))))

(paint (corner-split einstein 3))

; c
(define (square-limit painter n)
  (let ((quarter (rotate180 (corner-split painter n))))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

(paint (square-limit wave 2))