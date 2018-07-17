#lang racket/base

(require rackunit)
(require simply-scheme)

(provide majority)

(define (majority strategy-1 strategy-2 strategy-3)
  (lambda (customer-hand-so-far dealer-up-card)
    (cond
      [(and (strategy-1 customer-hand-so-far dealer-up-card) (strategy-2 customer-hand-so-far dealer-up-card)) #t]
      [(and (strategy-1 customer-hand-so-far dealer-up-card) (strategy-3 customer-hand-so-far dealer-up-card)) #t]
      [(and (strategy-2 customer-hand-so-far dealer-up-card) (strategy-3 customer-hand-so-far dealer-up-card)) #t]
      [else #f])))