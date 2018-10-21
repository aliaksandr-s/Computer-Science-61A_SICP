#lang racket

(require rnrs/mutable-pairs-6)
(require compatibility/mlist)
(require rackunit)

(define (reverse! lst)
  (define (helper! prev rest)
    (cond [(null? rest) prev]
          [else (let ([rest-of-rest (mcdr rest)]) 
                  (set-cdr! rest prev)
                  (helper! rest rest-of-rest))]))
  (helper! '() lst))


(define my-lst (mlist 1 2 3 4 5))
(check-equal? (reverse! my-lst) (mlist 5 4 3 2 1))