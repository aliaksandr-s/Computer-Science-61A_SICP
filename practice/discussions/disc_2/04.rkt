#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (expt base power)
  (cond [(< power 0) (/ 1 (expt base (* -1 power)))]
        [(= 0 power) 1]
        [else (* base (expt base (- power 1)))]))

(check-equal? (expt 3 2) 9)
(check-equal? (expt 2 3) 8)
(check-equal? (expt 3 -2) (/ 1 9))
(check-equal? (expt 3 -3) (/ 1 27))