#lang racket/base

(require rackunit)
(require simply-scheme)
(require "./best-total.rkt")

(provide dealer-sensitive)

(define (dealer-sensitive customer-hand-so-far dealer-up-card)
  (define less-than-17? 
    (and
      (> (best-total (se dealer-up-card)) 6)
      (< (best-total customer-hand-so-far) 17)))
  (define less-than-12? 
    (and
      (< (best-total (se dealer-up-card)) 7)
      (< (best-total customer-hand-so-far) 12)))
  (if (or less-than-17? less-than-12?) 
    #t 
    #f))

(check-equal? (dealer-sensitive `(KD 6S) `(KS)) #t)
(check-equal? (dealer-sensitive `(KD 6S) `(AS)) #t)
(check-equal? (dealer-sensitive `(KD 6S) `(7S)) #t)

(check-equal? (dealer-sensitive `(8D 2S) `(2S)) #t)
(check-equal? (dealer-sensitive `(8D 2S) `(6S)) #t)

(check-equal? (dealer-sensitive `(KD 6S) `(2S)) #f)
(check-equal? (dealer-sensitive `(KD 6S) `(6S)) #f)

(check-equal? (dealer-sensitive `(KD 8S) `(AS)) #f)
(check-equal? (dealer-sensitive `(KD 8S) `(2S)) #f)