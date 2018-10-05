#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./tables.rkt")
(require "./utils.rkt")

(provide (all-defined-out))

(define basic-object%
  (class object%
    (init-field [properties (make-table)])
    (super-new)
    (define/public (put key val)
      (insert! key val properties))
    (define/public (get key)
      (lookup key properties)) ))