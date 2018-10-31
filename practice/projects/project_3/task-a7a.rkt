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
(define Alex (new person% [name 'Alex] [place Home]))

(check-equal? (money-left Alex) 100)
(check-equal? (send Alex pay-money 200) #f)
(check-equal? (send Alex pay-money 50) #t)
(check-equal? (send Alex add-money 50) #t)
(check-equal? (money-left Alex) 100)