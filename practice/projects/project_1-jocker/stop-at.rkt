#lang racket/base

(require rackunit)
(require simply-scheme)
(require "./best-total.rkt")

(provide stop-at)

(define (stop-at n)
  (lambda (customer-hand-so-far dealer-up-card) 
    (if (< (best-total customer-hand-so-far) n) 
      #t 
      #f)))

(check-equal? ((stop-at 17) `(AD) `(4S)) #t)
(check-equal? ((stop-at 10) `(4S 2H) `(4S)) #t)
(check-equal? ((stop-at 17) `(KD 10S) `(4S)) #f)