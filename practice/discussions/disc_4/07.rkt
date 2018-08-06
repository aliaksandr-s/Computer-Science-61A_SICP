#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (all-satisfies sent pred)
  (null? (filter (lambda (x) (not (pred x))) sent)))

(check-equal? (all-satisfies '(1 2 3 4) number?) #t)
(check-equal? (all-satisfies '(1 a 3 4) number?) #f)