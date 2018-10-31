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

(define Home (new place% [name 'Home]))
(define Alex (new person% [name 'Alex] [place Home]))

(check-equal? (send Noahs menu) '((bagel . 0.50)))
(check-exn exn:fail? (lambda () (send Noahs sell Alex 'pizza)))

(check-equal? (send Alex pay-money 100) #t)
(check-equal? (money-left Alex) 0)
(check-equal? (send Noahs sell Alex 'bagel) #f)

(send Alex add-money 50)
(check-equal? (send (send Noahs sell Alex 'bagel) get-name) 'bagel)
(check-equal? (money-left Alex) 49.5)