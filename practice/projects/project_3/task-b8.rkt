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
(define Jail (new place% [name 'Jail]))

(define Alex (new person% [name 'Alex] [place Noahs]))
(define Police (new police% [name 'Police] [place Noahs] [jail Jail]))

(define hammer (new thing% [name 'hammer]))
(define gun (new thing% [name 'gun]))
(send Noahs appear hammer)
(send Noahs appear gun)
(send Police take gun)
(send Alex take hammer)

(check-equal? (send hammer may-take? Police) hammer)
(check-equal? (send gun may-take? Alex) #f)

(check-equal? (owner-things Alex) '(hammer))
(check-equal? (owner-things Police) '(gun))

(send Police take hammer)
(send Alex take gun)

(check-equal? (owner-things Alex) '())
(check-equal? (owner-things Police) '(hammer gun))

