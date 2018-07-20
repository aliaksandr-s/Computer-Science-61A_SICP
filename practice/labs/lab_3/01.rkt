#lang racket/base

(require rackunit)
(require simply-scheme)

(provide type-check)

(define (type-check func pred data)
  (if (pred data)
    (func data)
    #f))

(check-equal? (type-check sqrt number? 'hello) #f)
(check-equal? (type-check sqrt number? 4) 2)