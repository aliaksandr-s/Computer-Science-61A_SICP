#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (expt base power)
  (if (= 0 power) 
      1
      (* base (expt base (- power 1)))))

(check-equal? (expt 3 2) 9)
(check-equal? (expt 2 3) 8)