#lang racket

(require rackunit)

(define (mc-eval exp env)
  (cond ((self-evaluating? exp) exp)
	((variable? exp) (lookup-variable-value exp env))
  ((get (car exp)) ((get (car exp)) exp env))
	(else
	 (error "Unknown expression type -- EVAL" exp))))

(define operations (make-hash))
(define (get op) hash-ref operations op)
(define (put! key op) hash-set! operations op)

(define (text-of-quotation exp) (cadr exp))

(put! 'quote text-of-quotation)

(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
	((boolean? exp) true)
	(else false)))

(define (quoted? exp)
  (tagged-list? exp 'quote))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

;;; mocks
(define (variable? exp) #f)
(define (lookup-variable-value exp env) exp)
(define (assignment? exp) #f)
(define (eval-assignment exp env) exp)
(define (definition? exp) #f)
(define (eval-definition exp env) exp)
(define (if? exp) #f)
(define (eval-if exp env) exp)


(define empty-env '())
(check-equal? (mc-eval 3 empty-env) 3)
(check-equal? (mc-eval '4 empty-env) 4)