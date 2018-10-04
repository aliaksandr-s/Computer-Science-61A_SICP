#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./game-engine/tables.rkt")
(require "./game-engine/utils.rkt")
(require "./game-engine/person.rkt")
(require "./game-engine/place.rkt")
(require "./game-engine/thing.rkt")
;;; (require "./game-engine/adv-world.rkt")

(define Home (new place% [name 'Home]))
(define Alex (new person% [name 'Alex] [place Home]))
(define alex-car (new thing% [name 'alex-car]))
(define alex-garage (new garage% [name 'alex-garage]))

(can-go Home 'north alex-garage)

(send Home appear alex-car)
(send Alex take alex-car)
(send Alex go 'north)


(send alex-garage park alex-car)
(owner alex-car)
(owner-things Alex)

(define ticket (car (send Alex get-possessions)))
(define not-a-ticket (new thing% [name 'not-a-ticket]))
(define wrong-ticket (new ticket% [name 'ticket] [sn 111]))

(send alex-garage unpark ticket)
(owner-things Alex)