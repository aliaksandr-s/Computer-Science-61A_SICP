#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(provide (all-defined-out))

(define make-segment cons)
(define start-segment car)
(define end-segment cdr)

(define make-point cons)
(define x-point car)
(define y-point cdr)

(define (midpoint-segment segment)
  (make-point (/ (+ (x-point (start-segment segment)) 
                      (x-point (end-segment segment)))
                   2) 
                (/ (+ (y-point (start-segment segment)) 
                      (y-point (end-segment segment)))
                   2)))

(check-equal? (midpoint-segment (make-segment (make-point 2 1) 
                                              (make-point 2 3))) '(2 . 2))
(check-equal? (midpoint-segment (make-segment (make-point 5 2) 
                                              (make-point 1 2))) '(3 . 2))