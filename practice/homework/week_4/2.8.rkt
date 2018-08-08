#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)
(require "./2.7.rkt")

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (lower-bound y))
                 (- (upper-bound x) (upper-bound y))))

(check-equal? (sub-interval (make-interval 1 3)
                            (make-interval 3 7))
              (make-interval -2 -4))