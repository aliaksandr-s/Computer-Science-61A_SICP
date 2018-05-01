#lang racket/base

(require rackunit)
(require simply-scheme)

(define (g)
  (lambda (x) (+ x 2)))

(check-equal? 
  ((g) 1)
  3)
