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


(define (get-jocker-value total)
  (cond 
    [(= total 0) 11]
    [(< total 10) (- 10 total)]
    [else (- 21 total)]))

(check-equal? (get-jocker-value 0) 11)
(check-equal? (get-jocker-value 2) 8)
(check-equal? (get-jocker-value 6) 4)
(check-equal? (get-jocker-value 10) 11)
(check-equal? (get-jocker-value 11) 10)
(check-equal? (get-jocker-value 15) 6)
(check-equal? (get-jocker-value 20) 1)


(define (ace? card-value)
  (if (equal? (first card-value) 'A)
      #t
      #f))

(define (jocker? card-value)
  (if (equal? card-value 'XX)
      #t
      #f))

(check-equal? (jocker? 'XX) #t)
(check-equal? (jocker? '10C) #f)
(check-equal? (jocker? 'QC) #f)
(check-equal? (jocker? '2H) #f)


(define (get-value card total)
  (cond
    [(jocker? card) (get-jocker-value total)]
    [(ace? card) (get-ace-value total)]
    [else (get-simple-value card)]))

(check-equal? (get-value '5H 18) 5)
(check-equal? (get-value 'AD 8) 11)
(check-equal? (get-value 'AD 18) 1)
(check-equal? (get-value 'AD 11) 1)
(check-equal? (get-value 'KH 18) 10)
(check-equal? (get-value 'XX 18) 3)
(check-equal? (get-value 'XX 1) 9)
(check-equal? (get-value 'XX 6) 4)
(check-equal? (get-value 'XX 0) 11)


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

(check-equal? (best-total `(XX)) 11)
(check-equal? (best-total `(XX XX)) 21)
(check-equal? (best-total `(2D 2S XX)) 10)
(check-equal? (best-total `(2D 2S 4S XX)) 10)
(check-equal? (best-total `(KD 2S 4S XX)) 21)
(check-equal? (best-total `(KD JD XX)) 21)