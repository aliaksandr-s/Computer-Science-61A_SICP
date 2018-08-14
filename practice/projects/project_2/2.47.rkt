#lang racket/base

(require rackunit)
(require "./2.46.rkt")

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame) (car frame))
(define (edge1-frame frame) (cadr frame))
(define (edge2-frame frame) (caddr frame))


(define (make-frame-2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame-2 frame) (car frame))
(define (edge1-frame-2 frame) (cadr frame))
(define (edge2-frame-2 frame) (cddr frame))

(define v1 (make-vect 1 1))
(define v2 (make-vect 2 2))
(define v3 (make-vect 3 2))

(check-equal? (origin-frame (make-frame v1 v2 v3)) v1)
(check-equal? (edge1-frame (make-frame v1 v2 v3)) v2)
(check-equal? (edge2-frame (make-frame v1 v2 v3)) v3)

(check-equal? (origin-frame-2 (make-frame-2 v1 v2 v3)) v1)
(check-equal? (edge1-frame-2 (make-frame-2 v1 v2 v3)) v2)
(check-equal? (edge2-frame-2 (make-frame-2 v1 v2 v3)) v3)