#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(provide remove)

(define (remove item ls)
  (filter (lambda (x) (not (equal? x item))) ls))

(check-equal? (remove 1 '(1 2 3 1 5)) '(2 3 5))
(check-equal? (remove 'a '(a b c d a)) '(b c d))