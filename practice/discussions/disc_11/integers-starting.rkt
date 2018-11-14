#lang racket

(require rackunit)

(define (integers-starting n)
  (cons n (lambda () (integers-starting (+ 1 n)))))

(check-equal? (car (integers-starting 1)) 1)
(check-equal? (car ((cdr (integers-starting 1)))) 2)