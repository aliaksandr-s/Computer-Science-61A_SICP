#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)
(require "./12.rkt")

(define (count-of el ls)
  (define (count elem)
    (if (equal? el elem) 
        1
        0)) 
  (if (null? ls) 
      0
      (+ (count (car ls)) (count-of el (cdr ls)))))

(check-equal? (count-of 'a '(a a a b c d a)) 4)

(define (count-unique ls)
  (define (count el)
    (cons el (count-of el ls)))
  (map count (unique-elements ls)))

(check-equal? (count-unique '(a b b b c d d a e e f a a))
              '((a . 4) (b . 3) (c . 1) (d . 2) (e . 2) (f . 1)))