#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (foo x y) 
  (lambda (z k) k))

(check-equal? ((foo foo foo) foo 10) 10)
