#lang racket/base

(require rackunit)
(require simply-scheme)

(define (inc n) (+ n 1))
(define (square n) (* n n))

(define (compose func1 func2)
  (lambda (x) (func1 (func2 x))))

(check-equal?
  ((compose square inc) 6)
  49)