#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./game-engine/tables.rkt")
(require "./game-engine/utils.rkt")
(require "./game-engine/person.rkt")
(require "./game-engine/place.rkt")
(require "./game-engine/thing.rkt")

(define Noahs (new restaurant% [name 'Noahs] [food bagel%] [price 0.50]))

(define Alex (new person% [name 'Alex] [place Noahs]))

(check-equal? (owner-things Alex) '())
(send Alex buy 'bagel Noahs)
(check-equal? (owner-things Alex) '(bagel))