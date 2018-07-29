#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (falling n k)
  (define (iter n k res)
    (if (= k 1)
        (* res n)
        (iter (- n 1) (- k 1) (* n res))))
  (iter n k 1))

(check-equal? (falling 7 3) (* 7 6 5))