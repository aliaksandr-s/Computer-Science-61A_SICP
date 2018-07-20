#lang racket/base

(require rackunit)
(require simply-scheme)

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (inc n) (+ n 1))

(define (identity x) x)

(define (fact n)
  (product identity 1 inc n))

(define (pi-term n) 
  (if (even? n) 
      (/ (+ n 2) (+ n 1)) 
      (/ (+ n 1) (+ n 2))))

(check-equal?
  (fact 5)
  120)

(check-equal?
  (* (product pi-term 1 inc 6) 4)
  4096/1225)

