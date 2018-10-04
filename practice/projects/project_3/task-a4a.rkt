#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./adv.rkt")
(require "./tables.rkt")
(require "./adv-world.rkt")

(define Alex (new person% [name 'Alex] [place Noahs]))

(define singer (new person% [name 'rick] [place Sproul-Plaza]))
(send singer set-talk "My funny valentine, sweet comic valentine")

(define preacher (new person% [name 'preacher] [place Sproul-Plaza]))
(send preacher set-talk "Praise the Lord")


(define street-person (new person% [name 'harry] [place Telegraph-Ave]))
(send street-person set-talk "Brother, can you spare a buck")

(send Alex go 'north)
(send Alex go 'north)