#lang racket

(require rackunit)

(define police-called #f)

(define (call-the-police)
  (set! police-called #t))

(define (make-account balance password)
  (define wrong-pass-counter 0)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
    "Not enough money"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (check-password pass message)
    (if (eq? pass password) 
        (dispatch message)
        (begin (set! wrong-pass-counter (+ wrong-pass-counter 1))
               (when (> wrong-pass-counter 3)
                     (call-the-police))
               (error "Wrong password"))))
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Wrong message -- MAKE-ACCOUNT"
                        m))))
check-password)

(define acc (make-account 100 'secret-password))
(check-equal? ((acc 'secret-password 'withdraw) 40) 60)
(check-exn
   exn:fail?
   (lambda ()
     ((acc 'some-other-password 'deposit) 50)))
(check-equal? police-called #f)
(check-exn
   exn:fail?
   (lambda ()
     ((acc 'some-other-password 'deposit) 50)))
(check-exn
   exn:fail?
   (lambda ()
     ((acc 'some-other-password 'deposit) 50)))
(check-exn
   exn:fail?
   (lambda ()
     ((acc 'some-other-password 'deposit) 50)))
(check-equal? police-called #t)