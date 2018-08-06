#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (list-4 a b c d)
  (cons a (cons b (cons c (cons d '())))))

(check-equal? (list-4 1 2 3 4) (list 1 2 3 4))