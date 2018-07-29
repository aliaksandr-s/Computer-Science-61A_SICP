#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (bar x y) x)

(check-equal? (bar (bar (bar 10 bar) bar) bar) 10)
