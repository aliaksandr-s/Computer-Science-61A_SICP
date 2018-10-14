#lang racket

(require rackunit)

(define (make-account balance password)
  (define passwords (list password))
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
    "Not enough money"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (check-password pass message)
    (if (not (memq pass passwords))
        (error "Wrong password")
        (dispatch message)))
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Wrong message -- MAKE-ACCOUNT"
                        m))))
check-password)

(define (make-joint acc pass joint-pass)
  (define (joint-acc j-pass message)
    (if (eq? joint-pass j-pass)
        (acc pass message)
        (error "Wrong password")))
  joint-acc)

(define peter-acc (make-account 100 'open-sesame))
(check-equal? ((peter-acc 'open-sesame 'withdraw) 40) 60)

(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))
(check-equal? ((paul-acc 'rosebud 'withdraw) 20) 40)

(check-equal? ((peter-acc 'open-sesame 'deposit) 10) 50)
(check-equal? ((paul-acc 'rosebud 'deposit) 10) 60)

(check-exn
   exn:fail?
   (lambda ()
     ((peter-acc 'rosebud 'deposit) 50)))
(check-exn
   exn:fail?
   (lambda ()
     ((paul-acc 'open-sesame 'deposit) 50)))