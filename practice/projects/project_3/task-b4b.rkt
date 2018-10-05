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
(define Locked-palace (new locked-place% [name 'Locked-place]))
(define Garage (new garage% [name 'Garage]))
(define Pen (new thing% [name 'Pen]))
(define Ticket (new ticket% [name 'Ticket] [sn 0]))
(define Alex (new person% [name 'Alex] [place Dormitory]))

(check-equal? (place? Dormitory) #t)
(check-equal? (place? Locked-palace) #t)
(check-equal? (place? Garage) #t)
(check-equal? (place? Alex) #f)
(check-equal? (place? Ticket) #f)
(check-equal? (thing? Pen) #t)
(check-equal? (thing? Ticket) #t)
(check-equal? (person? Alex) #t)
(check-equal? (person? Dormitory) #f)