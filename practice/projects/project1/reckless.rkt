#lang racket/base

(require rackunit)
(require simply-scheme)
(require "./stop-at.rkt")

(provide reckless)

(define (reckless strategy)
  (define (reckless-strategy customer-hand-so-far dealer-up-card)
    (strategy (butlast customer-hand-so-far) dealer-up-card))
  reckless-strategy)

(check-equal? ((reckless (stop-at 17)) `(10D 5S 7S) `(4S)) #t)
(check-equal? ((reckless (stop-at 10)) `(4S 2H 10S) `(4S)) #t)
(check-equal? ((reckless (stop-at 17)) `(KD 10S 10H) `(4S)) #f)