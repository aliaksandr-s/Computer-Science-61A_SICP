#lang racket

(require rackunit)

(define (reverse-vector! vec)
  (define vec-copy (vector-copy vec))
  (define (loop cntr rev-cntr)
    (if (< rev-cntr 0) 
        'done
        (begin (vector-set! vec cntr (vector-ref vec-copy rev-cntr))  
               (loop (+ 1 cntr) (- rev-cntr 1)))) ) 
  (loop 0 (- (vector-length vec) 1)))

(define a (vector 1 2 3 4 5))
(reverse-vector! a)
(check-equal? a (vector 5 4 3 2 1))