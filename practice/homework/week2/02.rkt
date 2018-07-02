#lang racket/base

(require rackunit)
(require simply-scheme)

(define (square n) (* n n))

(define (every f sequence)
  (if (empty? sequence)
      `()
      (sentence 
        (f (first sequence))
        (every f (butfirst sequence)))))

(check-equal?
  (every square `(1 2 3 4))
  `(1 4 9 16))

(check-equal? 
  (every first `(nowhere man))
  `(n m))