#lang racket/base

(require (planet soegaard/sicp:2:1/sicp))

(define (split orig-placer split-placer)
  (define (iter painter n)
    (if (= n 0)
        painter
        (let ((smaller (iter painter (- n 1)))) 
          (orig-placer painter (split-placer smaller smaller)))))
  (lambda (painter n) (iter painter n)))


(define right-split (split beside below))
(define up-split (split beside below))

(paint (right-split einstein 3))