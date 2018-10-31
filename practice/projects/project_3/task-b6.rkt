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