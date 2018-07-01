#lang racket/base

(require rackunit)
(require simply-scheme)

(define (inc n) (+ n 1))

(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(check-equal?
  (prime? 5)
  #t)

(check-equal?
  (prime? 6)
  #f)


(define (filtered-accumalate combiner null-value term a next b filter)
  (cond [(> a b)
          null-value]
        [(equal? (filter a) #f)
          (filtered-accumalate combiner null-value term (next a) next b filter)]
        [else
          (combiner (term a)
            (filtered-accumalate combiner null-value term (next a) next b filter))]))

(check-equal?
  (filtered-accumalate + 0 square 1 inc 5 prime?)
  39)