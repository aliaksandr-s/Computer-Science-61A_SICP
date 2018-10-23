#lang racket

(require rnrs/mutable-pairs-6)
(require compatibility/mlist)
(require rackunit)
(require racket/trace)

(define (square x) (* x x))

(define (deep-map! proc deep-ls)
  (cond [(null? deep-ls) deep-ls]
        [(mlist? (mcar deep-ls)) 
          (begin (deep-map! proc (mcar deep-ls)) 
                 (deep-map! proc (mcdr deep-ls)))]
        [else
          (set-car! deep-ls (proc (mcar deep-ls)))
          (deep-map! proc (mcdr deep-ls))]))

(define my-lst (mlist 1 2 (mlist 3 (mlist 4 5) (mlist 6 (mlist 7 8)) 9)))
(deep-map! square my-lst)
(check-equal? my-lst (mlist 1 4 (mlist 9 (mlist 16 25) (mlist 36 (mlist 49 64)) 81)))