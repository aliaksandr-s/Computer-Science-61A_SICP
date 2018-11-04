#lang racket

(require rackunit)

(define (sum-of-vector vec)
  (define res 0)
  (define (loop cur)
    (if (equal? cur (vector-length vec)) 
        res 
        (begin (set! res (+ res (vector-ref vec cur))) 
               (loop (+ 1 cur)))))
               
  (loop 0))

(check-equal? (sum-of-vector (vector 1 2 3)) 6)