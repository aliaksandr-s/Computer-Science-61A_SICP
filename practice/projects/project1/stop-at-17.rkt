#lang racket/base

(require rackunit)
(require simply-scheme)
(require "./best-total.rkt")
(require "./stop-at.rkt")

(provide stop-at-17)

(define stop-at-17 (stop-at 17))

(check-equal? (stop-at-17 `(AD) `(4S)) #t)
(check-equal? (stop-at-17 `(8S 8H) `(4S)) #t)
(check-equal? (stop-at-17 `(KD 10S) `(4S)) #f)