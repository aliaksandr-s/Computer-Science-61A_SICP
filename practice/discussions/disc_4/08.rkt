#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (repeat-evens sent)
  (define (double-even num)
    (if (even? num) 
        (se num num) 
        num))
  (every double-even sent))

(check-equal? (repeat-evens '(1 2 3 4 5)) '(1 2 2 3 4 4 5))