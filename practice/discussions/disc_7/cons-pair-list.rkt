#lang racket

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define cons-pair-list%
  (class object%
    (init-field the-car the-cdr)
    (super-new)
    (define/public (get-car) the-car)
    (define/public (get-cdr) the-cdr)
    (define/public (listify) 
      (cons the-car (send the-cdr listify)))
    (define/public (map proc) 
      (new cons-pair-list% [the-car (proc the-car)] 
                           [the-cdr (send the-cdr map proc)]))
    (define/public (map! proc)
      (set! the-car (proc the-car))
      (send the-cdr map! proc))                       
    (define/public (length)
      (+ 1 (send the-cdr length)))
    (define/public (accumulate combiner init) 
      (combiner the-car 
                (send the-cdr accumulate combiner init))) ))

(define the-null-list%
  (class object%
    (super-new)
    (define/public (length) 0)
    (define/public (map proc) '())
    (define/public (map! proc) '())
    (define/public (accumulate combiner init) init)
    (define/public (listify) '()) ))

(define l (new cons-pair-list% 
               [the-car 1] 
               [the-cdr (new cons-pair-list% 
                             [the-car 2] 
                             [the-cdr (new the-null-list%)])]))


(check-equal? (send l get-car) 1)
(check-equal? (send (new the-null-list%) listify) '())
(check-equal? (send l length) 2)
(check-equal? (send (send (send l map (lambda (x) (* x x))) get-cdr) get-car) 4)
(check-equal? (send l listify) '(1 2))
(check-equal? (send l accumulate + 0) 3)

(define l-mutable (new cons-pair-list% 
               [the-car 3] 
               [the-cdr (new cons-pair-list% 
                             [the-car 5] 
                             [the-cdr (new the-null-list%)])]))

(send l-mutable map! (lambda (x) (* x x)))
(check-equal? (send (send l-mutable get-cdr) get-car) 25)

(define (make-oop-list ls)
  (if (null? ls) 
      (new the-null-list%) 
      (new cons-pair-list% [the-car (car ls)] 
                           [the-cdr (make-oop-list (cdr ls))])))

(check-equal? (send (make-oop-list '(1 2 3)) get-car) 1)
(check-equal? (send (send (make-oop-list '(1)) get-cdr) listify) '())