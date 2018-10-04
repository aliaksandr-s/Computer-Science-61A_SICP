#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./game-engine/tables.rkt")
(require "./game-engine/utils.rkt")
(require "./game-engine/person.rkt")
(require "./game-engine/place.rkt")
(require "./game-engine/thing.rkt")
(require "./game-engine/adv-world.rkt")


(define Dormitory (new place% [name 'Dormitory]))
(define Locked-place (new locked-place% [name 'Locked-place]))
(define Alex (new person% [name 'Alex] [place Dormitory]))

(can-go Dormitory 'north Locked-place)

(send Locked-place unlock)

(send Alex go 'north)