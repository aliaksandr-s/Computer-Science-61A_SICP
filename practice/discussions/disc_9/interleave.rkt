#lang racket

(require rnrs/mutable-pairs-6)
(require compatibility/mlist)
(require rackunit)
(require racket/trace)

(define (interleave! ls1 ls2)
  (cond ((null? ls1) ls2)
        ((null? ls2) ls1)
        (else (set-cdr! ls1 (interleave! ls2 (mcdr ls1)))
          ls1)))
(trace interleave!)

(define ls1 (mlist 1 2 3))
(define ls2 (mlist 4 5 6))
(check-equal? (interleave! ls1 ls2) (mlist 1 4 2 5 3 6))