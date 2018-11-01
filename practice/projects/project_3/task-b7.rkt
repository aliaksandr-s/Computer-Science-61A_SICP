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
(define Hall (new place% [name 'Hall]))
(define Jail (new place% [name 'Jail]))

(can-go Noahs 'up Hall)
(can-go Hall 'down Noahs)

(define Alex (new person% [name 'Alex] [place Noahs]))
(define Thief (new thief% [name 'Thief] [place Hall]))
(define Police (new police% [name 'Police] [place Noahs] [jail Jail]))

(define hammer (new thing% [name 'hammer]))
(send Hall appear hammer)
(send Thief take hammer)

(send Alex buy 'bagel Noahs)
(check-equal? (owner-things Alex) '(bagel))
(check-equal? (owner-things Thief) '(hammer))

(send Alex go 'up)

(check-equal? (owner-things Alex) '())
(check-equal? (owner-things Thief) '())
(check-equal? (owner-things Police) '(hammer bagel))
(check-equal? (whereis Thief) 'Jail)