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
(define Bob (new person% [name 'Bob] [place Dormitory]))

(define thing-1 (new thing% [name 'thing-1]))
(send Dormitory appear thing-1)
(define thing-2 (new thing% [name 'thing-2]))
(send Dormitory appear thing-2)
(define thing-3 (new thing% [name 'thing-3]))
(send Dormitory appear thing-3)
(define thing-4 (new thing% [name 'thing-4]))
(send Dormitory appear thing-4)
(define thing-5 (new thing% [name 'thing-5]))
(send Dormitory appear thing-5)

(send Alex take thing-1)
(send Bob take thing-2)

(check-equal? (owner-things Alex) '(thing-1))
(check-equal? (owner-things Bob) '(thing-2))

(send Alex take-all)

(check-equal? (owner-things Alex) '(thing-3 thing-4 thing-5 thing-1))
(check-equal? (owner-things Bob) '(thing-2))
