#lang racket

(require rackunit)

(define (make-account init-balance)
  (let ([balance init-balance]
        [transactions '()]) 
    (define (withdraw amount)
      (set! transactions (append transactions (list (list 'withdraw amount))))
      (set! balance (- balance amount)) balance)
    (define (deposit amount)
      (set! transactions (append transactions (list (list 'deposit amount))))
      (set! balance (+ balance amount)) balance)
    (define (dispatch msg)
      (cond
        ((eq? msg 'withdraw) withdraw)
        ((eq? msg 'deposit) deposit)
        ((eq? msg 'balance) balance)
        ((eq? msg 'transactions) transactions)
        ((eq? msg 'init-balance) init-balance) ) )
      dispatch) )

(define (make-account-2 init-amount)
   (let ([balance init-amount])
      (define (withdraw amount)
         (set! balance (- balance amount)) balance)
      (define (deposit amount)
         (set! balance (+ balance amount)) balance)
      (define (dispatch msg)
         (cond
            ((eq? msg 'withdraw) withdraw)
            ((eq? msg 'deposit) deposit)
            ((eq? msg 'balance) balance)
            ((eq? msg 'init-balance) init-amount) ) )
         dispatch) )

(define a1 (make-account 100))
(define a2 (make-account-2 100))

(check-equal? ((a1 'deposit) 50) ((a2 'deposit) 50))
(check-equal? ((a1 'withdraw) 10) ((a2 'withdraw) 10))
(check-equal? (a1 'balance) 140)
(check-equal? (a2 'balance) 140)
(check-equal? (a1 'init-balance) 100)
(check-equal? (a2 'init-balance) 100)
(check-equal? (a1 'transactions) '((deposit 50) (withdraw 10)))