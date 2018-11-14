#lang racket

(require rackunit)

(define (ones)
  (cons 1 ones))

(check-equal? (car (ones)) 1)
(check-equal? (car ((cdr (ones)))) 1)