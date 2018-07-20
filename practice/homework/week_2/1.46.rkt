#lang racket/base

(require rackunit)
(require simply-scheme)

(define (square x) (* x x))
(define (average x y)
  (/ (+ x y) 2))

(define (iterative-improve good-enough? improve)
  (lambda (x) 
    (define (iter n)
      (if (good-enough? n)
          n
          (iter (improve n))))
    (iter x)))

(define (sqrt x) 
  ((iterative-improve 
    (lambda (y) 
      (< (abs (- (square y) x)) 
         0.0001)) 
    (lambda (y) 
      (average y (/ x y)))) 
  1.0))


(check-true
  (and (< 2.9 (sqrt 9)) (> 3.1 (sqrt 9))))