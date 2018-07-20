#lang racket/base

(require rackunit)
(require simply-scheme)
(require "./01.rkt")

(define (make-safe func pred)
  (lambda (data)
    (type-check func pred data)))

(define safe-sqrt (make-safe sqrt number?) )

(check-equal? (safe-sqrt 'hello) #f)
(check-equal? (safe-sqrt 4) 2)