#lang racket/base

(require rackunit)
(require simply-scheme)
(require "./suit-strategy.rkt")
(require "./stop-at.rkt")

(provide valentine)

(define valentine (suit-strategy 'H (stop-at 17) (stop-at 19)))

(check-equal? (valentine `(KD 6D) `(4S)) #t)
(check-equal? (valentine `(KD 8H) `(4S)) #t)
(check-equal? (valentine `(KD 8S) `(4S)) #f)
(check-equal? (valentine `(KD KS) `(4S)) #f)

