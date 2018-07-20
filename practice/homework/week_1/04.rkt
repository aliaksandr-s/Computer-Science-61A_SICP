#lang racket/base

(require rackunit)
(require simply-scheme)

(define (lastStep? sequence) 
  (empty? 
    (bf sequence)))

(define (second sequence)
  (first (bf sequence)))

(define (ordered? sequence) 
  (cond 
    [(lastStep? sequence) 
      #t]
    [(< 
      (second sequence) 
      (first sequence)) 
        #f]
    [else 
      (ordered? (bf sequence))]))

(check-equal? (ordered? `(2 3 4 5)) #t)
(check-equal? (ordered? `(9 11 12 5)) #f)
(check-equal? (ordered? `(9 9 9 9)) #t)

(check-equal? (lastStep? `(1 2)) #f)
(check-equal? (lastStep? `(1)) #t)

(check-equal? (second `(2 3)) 3)