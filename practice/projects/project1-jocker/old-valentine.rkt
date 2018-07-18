#lang racket/base

(require rackunit)
(require simply-scheme)
(require "./best-total.rkt")

(provide valentine)

(define (has-heart? hand)
  (cond 
    [(empty? hand) #f]
    [(equal? (last (first hand)) 'H) #t]
    [else (has-heart? (butfirst hand))]))

(check-equal? (has-heart? `(2S 2H)) #t)
(check-equal? (has-heart? `(AH)) #t)

(check-equal? (has-heart? `(2S AC 2D)) #f)
(check-equal? (has-heart? `()) #f)

(define (valentine customer-hand-so-far dealer-up-card)
  (cond
    [(< (best-total customer-hand-so-far) 17) #t]
    [(and 
      (has-heart? customer-hand-so-far) 
      (< (best-total customer-hand-so-far) 19)) #t]
    [else #f]))

(check-equal? (valentine `(KD 6D) `(4S)) #t)
(check-equal? (valentine `(KD 8H) `(4S)) #t)
(check-equal? (valentine `(KD 8S) `(4S)) #f)
(check-equal? (valentine `(KD KS) `(4S)) #f)