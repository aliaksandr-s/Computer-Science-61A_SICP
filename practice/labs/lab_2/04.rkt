#lang racket/base

(require rackunit)
(require simply-scheme)

(define f 3)
(define (f1) 3)
(define (f2 x) x)
(define (f3) (lambda () 3))
(define (f4) 
  (lambda () 
    (lambda (x) x)))

(check-equal? f 3)
(check-equal? (f1) 3)
(check-equal? (f2 3) 3)
(check-equal? ((f3)) 3)
(check-equal? (((f4)) 3) 3)