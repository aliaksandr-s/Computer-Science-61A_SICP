#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./game-engine/tables.rkt")
(require "./game-engine/utils.rkt")
(require "./game-engine/person.rkt")
(require "./game-engine/place.rkt")
(require "./game-engine/thing.rkt")
(require "./game-engine/adv-world.rkt")

;;; 1
(define Dormitory (new place% [name 'Dormitory]))
(define Kirin (new place% [name 'Kirin]))

(can-go Soda 'north Kirin)
(can-go Soda 'west Dormitory)
(can-go Dormitory 'east Soda)
(can-go Kirin 'south Soda)

(define Alex (new person% [name 'Alex] [place Dormitory]))

(define potstickers (new thing% [name 'potstickers]))
(send Kirin appear potstickers)

(send Dormitory exits)
(send Alex go 'east)
(send Alex go 'north)
(send Alex look-around)
(send Alex take potstickers)
(send Alex go 'south)
(send Alex go 'up)
(send Alex go 'west)
;;; (send Alex lose potstickers)
(send Alex look-around)
(send Brian take potstickers)


;;; (define Joe (new person% [name 'Joe] [place Telegraph-Ave]))
;;; (can-go Telegraph-Ave 'east (new place% [name 'Peoples-Park]))
;;; (send Joe go 'east)
;;; (send Joe get-place)

;;; (let ((where (send Joe get-place)))
;;;       (send where get-name))

;;; (eq? (send Telegraph-Ave look-in 'east) (send Joe get-place))
;;; (eq? (send Joe get-place) 'Peoples-Park)
;;; (eq? (send (send Joe get-place) get-name) 'Peoples-Park)