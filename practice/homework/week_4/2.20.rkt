#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (same-parity . lst)
  (if (even? (car lst))
      (filter even? lst)
      (filter odd? lst)))

(check-equal? (same-parity 1 2 3 4 5 6 7) '(1 3 5 7))
(check-equal? (same-parity 2 3 4 5 6 7) '(2 4 6))