#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./game-engine/tables.rkt")
(require "./game-engine/utils.rkt")
(require "./game-engine/person.rkt")
(require "./game-engine/place.rkt")
(require "./game-engine/thing.rkt")


(define thing-1 (new thing% [name 'thing-1]))
(check-equal? (send thing-1 edible?) #f)

(define bagel-1 (new bagel% [name 'b] [calories 10]))
(check-equal? (send bagel-1 get-calories) 10)
(check-equal? (send bagel-1 get-name) 'bagel)

(check-equal? (edible? bagel-1) #t)
(check-equal? (edible? thing-1) #f)

(define Dormitory (new place% [name 'Dormitory]))
(define Alex (new person% [name 'Alex] [place Dormitory]))

(define box (new thing% [name 'box]))
(define glue (new thing% [name 'glue]))
(define bagel-2 (new bagel% [name 'b] [calories 10]))
(define bagel-3 (new bagel% [name 'b] [calories 10]))

(send Dormitory appear box)
(send Dormitory appear glue)
(send Dormitory appear bagel-2)
(send Dormitory appear bagel-3)

(send Alex take box)
(send Alex take glue)
(send Alex take bagel-2)
(send Alex take bagel-3)

(check-equal? (owner-things Alex) '(bagel bagel glue box))
(check-equal? (place-things Dormitory) '(bagel bagel glue box))
(check-equal? (strength Alex) 10)

(send Alex eat)

(check-equal? (owner-things Alex) '(glue box))
(check-equal? (place-things Dormitory) '(glue box))
(check-equal? (strength Alex) 30)