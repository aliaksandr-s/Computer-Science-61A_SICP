#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(require "./utils.rkt")
(require "./basic-object.rkt")

(provide (all-defined-out))

(define thing%
  (class basic-object%
    (init-field name
                [possessor 'no-one])
    (super-new)
    (define/public (edible?) #f)
    (define/public (get-possessor) possessor)
    (define/public (get-name) name)
    (define/public (type) 'thing)
    (define/override (thing?) #t)
    (define/public (change-possessor new-possessor) 
      (set! possessor new-possessor)) ))

(define ticket%
  (class thing%
    (init-field sn)
    (define/public (get-sn) sn)
    (super-new)))

(define laptop%
  (class thing%
    (super-new)
    (inherit-field possessor)
    (define/public (connect password)
      (when (eq? possessor 'no-one)
            (error "A laptop should have a possessor to connect"))
      (let ([hotspot (send possessor get-place)]) 
           (send hotspot connect this password)))
    (define/public (surf url) 
      (when (eq? possessor 'no-one)
            (error "A laptop should have a possessor to connect"))
      (let ([hotspot (send possessor get-place)]) 
           (send hotspot surf this url))) ))

(define food%
  (class thing%
    (super-new)
    (init-field calories)
    (define/override (edible?) #t)
    (define/public (get-calories) calories) ))

(define bagel%
  (let ([name 'bagel] [calories 10])
    (class food%
    (super-new)
    (define/override (get-name) name)
    (define/override (get-calories) calories) )))