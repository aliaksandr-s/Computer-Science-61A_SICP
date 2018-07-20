#lang racket/base

(require rackunit)
(require simply-scheme)

(define (inc n) (+ n 1))

(define (double func)
  (lambda (arg) (func (func arg))))

(check-equal?
  (inc 1)
  2)

(check-equal?
  ((double inc) 1)
  3)

(check-equal?
  (((double (double double)) inc) 5)
  21)
