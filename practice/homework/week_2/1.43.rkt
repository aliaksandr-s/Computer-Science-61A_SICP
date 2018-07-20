#lang racket/base

(require rackunit)
(require simply-scheme)

(define (square x) (* x x))
(define (compose f g) (lambda (x) (f (g x))))

(define (repeated f n)
  (if (< n 1) 
    (lambda (x) x)
    (compose f (repeated f (- n 1)))))

(check-equal? 
  ((repeated square 2) 5) 
  625)