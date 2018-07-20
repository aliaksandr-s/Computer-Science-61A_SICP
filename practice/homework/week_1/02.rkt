#lang racket/base

(require rackunit)
(require simply-scheme)

(define (square n) 
  (* n n))

(define (squares sequence) 
  (if (empty? sequence)
    `()
    (sentence 
      (square 
        (first sequence)) 
      (squares 
        (butfirst sequence)))))

(check-equal? (squares `(2 3 4 5)) `(4 9 16 25))