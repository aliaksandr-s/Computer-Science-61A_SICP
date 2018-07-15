#lang racket/base

(require rackunit)
(require simply-scheme)

(provide best-total)

(define (get-simple-value card-value)
  (let ([value (butlast card-value)] 
        [ten-value-cards `(J Q K)]) 
    (if (member? value ten-value-cards)
        10
        value)))

(check-equal? (get-simple-value '8S) 8)
(check-equal? (get-simple-value '10H) 10)
(check-equal? (get-simple-value 'JD) 10)
(check-equal? (get-simple-value 'QC) 10)
(check-equal? (get-simple-value 'KS) 10)


(define (get-ace-value total)
  (let ([possible-total (+ 11 total)])
    (if (<= possible-total 21)
        11
        1)))

(check-equal? (get-ace-value 8) 11)
(check-equal? (get-ace-value 10) 11)
(check-equal? (get-ace-value 11) 1)
(check-equal? (get-ace-value 15) 1)


(define (isAce card-value)
  (if (equal? (first card-value) 'A)
      #t
      #f))

(check-equal? (isAce 'AD) #t)
(check-equal? (isAce '10C) #f)
(check-equal? (isAce 'QC) #f)
(check-equal? (isAce '2H) #f)


(define (get-value card total)
  (if (isAce card)
      (get-ace-value total)
      (get-simple-value card)))

(check-equal? (get-value '5H 18) 5)
(check-equal? (get-value 'AD 8) 11)
(check-equal? (get-value 'AD 18) 1)
(check-equal? (get-value 'AD 11) 1)
(check-equal? (get-value 'KH 18) 10)


(define (best-total hand)
  (define (iter rest-hand card total)
    (if (empty? rest-hand)
        (+ total (get-value card total))
        (iter (bf rest-hand) (first rest-hand) (+ total (get-value card total)))))
  (iter (bf hand) (first hand) 0))

(check-equal? (best-total `(8S AD)) 19)
(check-equal? (best-total `(10S AD)) 21)
(check-equal? (best-total `(8S 5H AD)) 14)
(check-equal? (best-total `(9H AS AD)) 21)
(check-equal? (best-total `(AD AS)) 12)
(check-equal? (best-total `(AD)) 11)



