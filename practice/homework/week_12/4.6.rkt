#lang racket

(require rackunit)

(define let-exp '(let ((x 3) (y 2)) (+ x y)))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

(define (let? expr) (tagged-list? expr 'let)) 
(define (let-vars expr) (map car (cadr expr)))
(define (let-inits expr) (map cadr (cadr expr)))
(define (let-body expr) (cddr expr))

(define (let->combination expr) 
  (cons (make-lambda (let-vars expr) (let-body expr)) 
        (let-inits expr)))

(check-equal? (let? let-exp) #t)
(check-equal? (let-vars let-exp) '(x y))
(check-equal? (let-inits let-exp) '(3 2))
(check-equal? (let-body let-exp) '((+ x y)))

(check-equal? (let->combination let-exp) '((lambda (x y) (+ x y)) 3 2))