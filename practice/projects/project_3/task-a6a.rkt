#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./game-engine/tables.rkt")
(require "./game-engine/utils.rkt")
(require "./game-engine/person.rkt")
(require "./game-engine/place.rkt")
(require "./game-engine/thing.rkt")

(define Home (new place% [name 'Home]))
(define Jail (new place% [name 'Jail]))

(define Thief (new person% [name 'Thief] [place Home]))
(send Thief go-directly-to Jail)

(check-equal? (whereis Thief) 'Jail)