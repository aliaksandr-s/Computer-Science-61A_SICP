#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define test (not (equal? (quote (+ 1 2)) (+ 1 2))))
(check-equal? test #t)
