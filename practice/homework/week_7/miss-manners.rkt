#lang racket 

(require rackunit)

(define person%
  (class object%
  (init-field name)
  (super-new)
  (define/public (say phrase) phrase) ))

(define miss-manner%
  (class object%
  (init-field obj)
  (super-new)
  (define/public (please message arg) 
    (dynamic-send obj message arg)) ))

(define dan (new person% [name 'Dan]))
(check-equal? (send dan say '(Hello)) '(Hello))

(define fussy-dan (new miss-manner% [obj dan]))
(check-exn
   exn:fail?
   (lambda ()
     (send fussy-dan say '(Hello))))
(check-equal? (send fussy-dan please 'say '(Hello)) '(Hello))