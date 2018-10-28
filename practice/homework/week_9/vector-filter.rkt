#lang racket

(require rackunit)
(require "./vector-append.rkt")


(define (vector-filter pred vec)
  (define res-vec (make-vector 0))
  
  (define (loop vec cntr)
    (cond [(equal? (vector-length vec) cntr)
            #f]
          [(pred (vector-ref vec cntr)) 
            (set! res-vec (vector-append res-vec (vector (vector-ref vec cntr))))
            (loop vec (+ 1 cntr))] 
          [else (loop vec (+ 1 cntr))]))
  
  (loop vec 0)
  res-vec)

(define (bigger-than-3 x) (> x 3))
(check-equal? (vector-filter bigger-than-3 (vector 1 2 3 4 5 6)) (vector 4 5 6))