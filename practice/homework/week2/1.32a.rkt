#lang racket/base

(require rackunit)
(require simply-scheme)

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (identity x) x)

(define (inc n) (+ n 1))

(define (sum a b)
  (accumulate + 0 identity a inc b))

(define (product a b)
  (accumulate * 1 identity a inc b))

(check-equal?
  (sum 1 5)
  15)

(check-equal?
  (sum 10 20)
  165)

(check-equal?
  (product 1 5)
  120)
