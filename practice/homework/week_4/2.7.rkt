#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(provide (all-defined-out))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))
                
(define (make-interval a b) (cons a b))
(define lower-bound car)
(define upper-bound cdr)

(check-equal? (add-interval (make-interval 1 3)
                            (make-interval 3 7))
              (make-interval 4 10))