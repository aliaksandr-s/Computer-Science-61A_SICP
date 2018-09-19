#lang racket/base

(require rackunit)
(require racket/trace)

(provide (all-defined-out))

(define type-tag car)
(define content cdr)

(define (make-tagged-record tag-name record)
  (cons tag-name record))