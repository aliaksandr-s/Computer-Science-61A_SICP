#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (num-satisfies sent pred)
  (count (keep pred sent)))

(check-equal? (num-satisfies '(a b c d a a) (lambda (x) (equal? x 'a))) 3)
(check-equal? (num-satisfies '(a 1 2 3 b d) number?) 3)