#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))

(check-equal? (car (cons 3 5)) 3)
(check-equal? (cdr (cons 3 5)) 5)