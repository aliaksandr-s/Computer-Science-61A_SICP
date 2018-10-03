#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./adv.rkt")
(require "./tables.rkt")

(define (whereis person)
  (send (send person get-place) get-name))

(define Dormitory (new place% [name 'Dormitory]))
(define Joe (new person% [name 'Joe] [place Dormitory]))
(check-equal? (whereis Joe) 'Dormitory)

(define (owner thing)
  (let ([possessor (send thing get-possessor)])
    (if (object? possessor) 
        (send possessor get-name) 
        possessor)))

(define potstickers (new thing% [name 'potstickers]))
(send Dormitory appear potstickers)
(check-equal? (owner potstickers) 'no-one)
(send Joe take potstickers)
(check-equal? (owner potstickers) 'Joe)
(send Joe lose potstickers)
(check-equal? (owner potstickers) 'no-one)