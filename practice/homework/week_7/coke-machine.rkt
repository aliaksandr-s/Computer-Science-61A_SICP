#lang racket

(require rackunit)
(require racket/trace)

(define coke-machine%
  (class object%
  (super-new) 
  (init-field cokes-limit coke-price
              [cokes 0]
              [money 0])
  (define/public (coke) 
    (match (cons cokes money) 
           [(cons 0 _) (error "MACHINE IS EMPTY")] 
           [(cons _ (? (lambda (m) (< m coke-price)))) (error "NOT ENOUGH MONEY")]
           [_ (set! cokes (- cokes 1))
              (let ([change (- money coke-price)]) 
                   (set! money 0)
                   change)]))
  (define/public (fill amount) (set! cokes amount)) 
  (define/public (deposit amount) (set! money (+ money amount)))
  (define/public (cokes-amount) cokes) ))

(define my-machine (new coke-machine% [cokes-limit 80] [coke-price 70]))
(check-exn (regexp "MACHINE IS EMPTY") (lambda () (send my-machine coke)))
(send my-machine fill 60)
(check-exn (regexp "NOT ENOUGH MONEY") (lambda () (send my-machine coke)))
(send my-machine deposit 25)
(check-exn (regexp "NOT ENOUGH MONEY") (lambda () (send my-machine coke)))
(send my-machine deposit 25)
(send my-machine deposit 25)
(check-equal? (send my-machine coke) 5)
(check-equal? (send my-machine cokes-amount) 59)