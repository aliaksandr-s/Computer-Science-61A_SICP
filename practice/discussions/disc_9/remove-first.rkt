#lang racket

(require rnrs/mutable-pairs-6)
(require compatibility/mlist)
(require rackunit)

(define (remove-first! ls) 
  (set-car! ls (mcar (mcdr ls)))
  (set-cdr! ls (mcdr (mcdr ls))) ls)

(define my-lst (mlist 1 2 3 4 5))
(remove-first! my-lst)
(check-equal? my-lst (mlist 2 3 4 5))