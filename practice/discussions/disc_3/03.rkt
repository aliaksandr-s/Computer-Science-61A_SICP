#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (count-stair-ways n)
  (cond [(= n 0) 1]
        [(< n 0) 0]
        [else (+ (count-stair-ways (- n 1))
                 (count-stair-ways (- n 2)))]))

(check-equal? (count-stair-ways 3) 3)
(check-equal? (count-stair-ways 4) 5)
(check-equal? (count-stair-ways 1) 1)