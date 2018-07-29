#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (subset-sum seq n)
  (cond [(= n 0) #t]
        [(< n 0) #f]
        [(empty? seq) #f]
        [else (or (subset-sum (bf seq) n) 
                  (subset-sum (bf seq) (- n (first seq))))]))

(check-equal? (subset-sum `(2 4 7 3) 5) #t)
(check-equal? (subset-sum `(1 9 5 7 3) 2) #f)