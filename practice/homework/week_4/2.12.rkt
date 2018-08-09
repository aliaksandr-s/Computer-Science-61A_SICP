#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)
(require "./2.7.rkt") 

(define (center i) (/ (+ (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c percent)
  (define width (/ (* c percent) 100))
  (make-interval (- c width) (+ c width)))

(define (percent interval)
  (define width (/ (- (upper-bound interval) (lower-bound interval)) 2))
  (* (/ width (center interval)) 100)) 

(check-equal? (make-center-percent 4 50) (make-interval 2 6))
(check-equal? (percent (make-interval 2 6)) 50)