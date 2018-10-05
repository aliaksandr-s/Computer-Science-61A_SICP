#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./game-engine/tables.rkt")
(require "./game-engine/utils.rkt")
(require "./game-engine/person.rkt")
(require "./game-engine/place.rkt")
(require "./game-engine/thing.rkt")

(define Dormitory (new place% [name 'Dormitory]))
(define Alex (new person% [name 'Alex] [place Dormitory]))
(define Hotspot (new hotspot% [name 'Hotspot] [password 'secret]))

(can-go Dormitory 'east Hotspot)
(can-go Hotspot 'west Dormitory)

(define laptop (new laptop% [name 'laptop]))
(send Dormitory appear laptop)
(send Alex take laptop)

(check-exn exn:fail? (lambda () (send laptop connect 'secret)))
(send Alex go 'east)
(check-exn exn:fail? (lambda () (send laptop connect 'aabbb)))
(send laptop connect 'secret)
(check-equal? (map get-name (send Hotspot get-connected-laptops)) '(laptop))
(check-exn exn:fail? (lambda () (send Hotspot connect laptop 'secret)))

(send Alex go 'west)
(check-equal? (send Hotspot get-connected-laptops) '())
(check-equal? (send Hotspot get-things) '())

(check-exn exn:fail? (lambda () (send laptop surf "http://www.cs.berkeley.edu")))