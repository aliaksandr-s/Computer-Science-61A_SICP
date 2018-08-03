#lang racket/base

(require rackunit)
(require simply-scheme)
(require racket/trace)

(define (make-rational num den)
  (cons num den) )

(define (numerator rat)
  (car rat) )

(define (denominator rat)
  (cdr rat) )

(define (*rat a b)
  (make-rational  (* (numerator a) (numerator b) )
                  (* (denominator a) (denominator b) ) ) )

(define (+rat a b)
  (make-rational  (+ (* (numerator a) (denominator b) ) 
                     (* (denominator a) (numerator b) ))
                  (* (denominator a) (denominator b) ) ) )

(define (print-rat rat)
  (word (numerator rat)  '/  (denominator rat) ) )

(check-equal? (print-rat  (*rat  (make-rational 2 3) (make-rational 1 4) ) ) "2/12")
(check-equal? (print-rat  (+rat  (make-rational 2 3) (make-rational 1 4) ) ) "11/12")

;;; (print-rat  (make-rational 2 3) )
;;; (print-rat  (*rat  (make-rational 2 3) (make-rational 1 4) ) )