#lang racket/base

(require rackunit)

(define make-vect cons)
(define xcor-vect car)
(define ycor-vect cdr)

(provide (all-defined-out))

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2)) 
             (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2)) 
             (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect scale v)
  (make-vect (* (xcor-vect v) scale) 
             (* (ycor-vect v) scale)))

(check-equal? (xcor-vect (make-vect 3 5)) 3)
(check-equal? (ycor-vect (make-vect 3 5)) 5)

(check-equal? (add-vect (make-vect 1 2) (make-vect 2 1)) (make-vect 3 3))
(check-equal? (sub-vect (make-vect 3 3) (make-vect 2 1)) (make-vect 1 2))
(check-equal? (scale-vect 3 (make-vect 2 1)) (make-vect 6 3))