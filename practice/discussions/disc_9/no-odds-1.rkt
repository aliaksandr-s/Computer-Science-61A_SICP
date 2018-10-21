#lang racket

(require rnrs/mutable-pairs-6)
(require compatibility/mlist)
(require rackunit)

(define (no-odd! ls)
  (cond [(null? ls) '()]
        [(odd? (mcar ls)) (no-odd! (mcdr ls))]
        [else (set-cdr! ls (no-odd! (mcdr ls))) 
              ls]))

(define my-lst (mlist 1 2 3 4 5))
(check-equal? (no-odd! my-lst) (mlist 2 4))