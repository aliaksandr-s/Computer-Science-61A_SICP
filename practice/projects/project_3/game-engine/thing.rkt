#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./utils.rkt")
(require "./basic-object.rkt")

(provide (all-defined-out))

(define thing%
  (class basic-object%
    (init-field name
                [possessor 'no-one])
    (super-new)
    (define/public (get-possessor) possessor)
    (define/public (get-name) name)
    (define/public (type) 'thing)
    (define/public (change-possessor new-possessor) 
      (set! possessor new-possessor)) ))

(define ticket%
  (class thing%
    (init-field sn)
    (define/public (get-sn) sn)
    (super-new)))