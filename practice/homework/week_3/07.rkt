#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (number-of-partitions n)
  (count 1 n))

(define (count k n)
  (cond [(> k n) 0]
        [(= k n) 1]
        [else (+ (count (+ 1 k) n) 
                 (count k (- n k)))]))

(check-equal? (number-of-partitions 5) 7)
(check-equal? (number-of-partitions 3) 3)