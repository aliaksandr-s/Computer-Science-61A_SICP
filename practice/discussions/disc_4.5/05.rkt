#lang racket/base

(require rackunit)
(require racket/trace)
(require simply-scheme)

(define (sentfn fn ls)
  (map (lambda (sent) (every fn sent)) ls))

(define (square x) (* x x))
(check-equal? (sentfn square '((2 5) (3 1 6))) '((4 25) (9 1 36)))