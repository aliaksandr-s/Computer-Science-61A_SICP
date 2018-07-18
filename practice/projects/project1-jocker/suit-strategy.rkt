#lang racket/base

(require rackunit)
(require simply-scheme)
(require "./stop-at.rkt")

(provide suit-strategy)

(define (has-suit? hand suit)
  (cond 
    [(empty? hand) #f]
    [(equal? (last (first hand)) suit) #t]
    [else (has-suit? (butfirst hand) suit)]))

(check-equal? (has-suit? `(2S 2H) 'S) #t)
(check-equal? (has-suit? `(AH) 'H) #t)

(check-equal? (has-suit? `(2S AC 2D) 'H) #f)
(check-equal? (has-suit? `() 'H) #f)

(define (suit-strategy suit no-suit-strategy includes-suit-strategy)
  (lambda (customer-hand-so-far dealer-up-card)
    (if (has-suit? customer-hand-so-far suit)
      (includes-suit-strategy customer-hand-so-far dealer-up-card)
      (no-suit-strategy customer-hand-so-far dealer-up-card))))

(check-equal? ((suit-strategy 'D (stop-at 15) (stop-at 20)) `(KH 9D) `(4S)) #t)
(check-equal? ((suit-strategy 'D (stop-at 15) (stop-at 20)) `(KD JD) `(4S)) #f)
(check-equal? ((suit-strategy 'S (stop-at 15) (stop-at 20)) `(KH 7D) `(4S)) #f)
(check-equal? ((suit-strategy 'S (stop-at 15) (stop-at 20)) `(KS 7D) `(4S)) #t)