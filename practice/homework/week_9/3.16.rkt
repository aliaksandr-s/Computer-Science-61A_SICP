#lang sicp

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x)) 1)))

(define l3 (list 1 2 3))
(count-pairs l3)

(define l41 (list 1))
(define l4 (list l41 l41))
(count-pairs l4)

(define l71 (list 1))
(define l72 (cons l71 l71))
(define l7 (cons l72 l72))
(count-pairs l7)

(define linf (list 1 2 3))
(set-cdr! (cdr (cdr linf)) linf)
;(count-pairs linf)