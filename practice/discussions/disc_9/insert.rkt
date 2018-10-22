#lang racket

(require rnrs/mutable-pairs-6)
(require compatibility/mlist)
(require rackunit)

(define (insert! L val)
  (if (null? (mcdr L))
      (set-cdr! L (mlist val))
      (insert! (mcdr L) val)))

(define ls (mlist 1 2 3 4))
(insert! ls 5)
(check-equal? ls (mlist 1 2 3 4 5))