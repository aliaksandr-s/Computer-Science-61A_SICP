#lang racket/base

(require rackunit)
(require racket/trace)

(define (square n) (* n n))

(define (deep-map fn ls)
  (if (list? ls) 
      (map (lambda (el) (deep-map fn el)) ls)
      (fn ls)))

(define (deep-square tree) (deep-map square tree))

(define t1 '(1 (2 (3 4) 5) (6 7)))

(check-equal? (deep-square t1) '(1 (4 (9 16) 25) (36 49)))