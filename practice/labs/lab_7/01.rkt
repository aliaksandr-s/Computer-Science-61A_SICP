#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define person%
  (class object%
    (init-field name
                [last-phrase '()])
    (super-new)
    (define/public (say stuff) 
      (set! last-phrase stuff)
      stuff)
    (define/public (ask stuff) 
      (set! last-phrase (se '(would you please) stuff))
      (send this say (se '(would you please) stuff)))
    (define/public (greet) 
      (set! last-phrase (se '(hello my name is) name))
      (send this say (se '(hello my name is) name)))
    (define/public (repeat) last-phrase) ))

(define joe (new person% [name 'Joe]))

(check-equal? (send joe say '(some random phrase)) '(some random phrase))
(check-equal? (send joe repeat) '(some random phrase))

(define double-talker-1%
  (class person%
    (super-new)
    (define (say stuff) (se (super say stuff) (send this repeat))) 
    (override say)))

(define double-talker-2%
  (class person%
    (super-new)
    (define (say stuff) (se stuff stuff)) 
    (override say)))

(define double-talker-3%
  (class person%
    (super-new)
    (define (say stuff) (super say (se stuff stuff))) 
    (override say)))

(define double-joe-1 (new double-talker-1% [name 'Double-Joe]))
(send double-joe-1 say 'hello)

(define double-joe-2 (new double-talker-2% [name 'Double-Joe]))
(send double-joe-2 say 'hello)

(define double-joe-3 (new double-talker-3% [name 'Double-Joe]))
(send double-joe-3 say 'hello)