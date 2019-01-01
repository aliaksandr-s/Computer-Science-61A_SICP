#lang racket

(require rackunit)

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define (application? exp)
  (tagged-list? exp 'call))

(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))

(check-equal? (application? '(call + 1 2)) #t)
(check-equal? (application? '(+ 1 2)) #f)

(check-equal? (operator '(call + 1 2)) '+)
(check-equal? (operands '(call + 1 2)) '(1 2))