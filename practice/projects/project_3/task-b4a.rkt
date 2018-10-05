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

(define Dormitory (new place% [name 'Dormitory]))
(define Alex (new person% [name 'Alex] [place Dormitory]))

(send Alex put 'strength 50)
(check-equal? (send Alex get 'strength) 50)
(check-equal? (send Alex get 'wisdom) #f)