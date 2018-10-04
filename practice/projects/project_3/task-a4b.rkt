#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./adv.rkt")
(require "./tables.rkt")
(require "./adv-world.rkt")

(define Dormitory (new place% [name 'Dormitory]))
(define Locked-place (new locked-place% [name 'Locked-place]))
(define Alex (new person% [name 'Alex] [place Dormitory]))

(can-go Dormitory 'north Locked-place)

(send Locked-place unlock)

(send Alex go 'north)