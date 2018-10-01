#lang racket

(require rackunit)
(require racket/trace)

(define deck%
  (class object%
    (init-field cards)
    (super-new)
    (define/public (empty?) (null? cards))
    (define/public (deal) 
      (let ([top-card (if (send this empty?) '() (car cards))]) 
           (set! cards (remove top-card cards))
           top-card)) ))

(define my-deck (new deck% [cards '(AH 2H 3H)]))
(check-equal? (send my-deck empty?) #f)
(check-equal? (send my-deck deal) 'AH)
(check-equal? (send my-deck deal) '2H)
(check-equal? (send my-deck deal) '3H)
(check-equal? (send my-deck deal) '())
(check-equal? (send my-deck empty?) #t)