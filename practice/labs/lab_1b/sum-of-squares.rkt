#lang racket

(require rackunit)

(define (sum-of-squares num1 num2 num3)
  (define sum-of-all (+ (* num1 num1) (* num2 num2) (* num3 num3)))
  (define lowest (min num1 num2 num3))
  (- sum-of-all (* lowest lowest)))

(check-equal? (sum-of-squares 1 2 3) 13)
(check-equal? (sum-of-squares -3 -2 -2) 8)
(check-equal? (sum-of-squares 1 1 1) 2)