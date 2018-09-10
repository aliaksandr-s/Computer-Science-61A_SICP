;; Scheme calculator -- evaluate simple expressions

; The read-eval-print loop:
#lang racket

(require simply-scheme)
(require racket/trace)

(define (calc)
  (display "calc: ")
  (println (calc-eval (read)))
  (calc))

; Evaluate an expression:
(define (calc-eval exp)
  (cond ((or (number? exp) 
             (word? exp)) exp)
        ((list? exp) (calc-apply (car exp) (map calc-eval (cdr exp))))
	  (else (error "Calc: bad expression:" exp))))

; Apply a function to arguments:
(define (calc-apply fn args)
  (cond ((eq? fn '+) (foldr + 0 args))
        ((eq? fn '-) (cond ((null? args) (error "Calc: no args to -"))
              ((= (length args) 1) (- (car args)))
              (else (- (car args) (foldr + 0 (cdr args))))))
        ((eq? fn '*) (foldr * 1 args))
        ((eq? fn '/) (cond ((null? args) (error "Calc: no args to /"))
              ((= (length args) 1) (/ (car args)))
              (else (/ (car args) (foldr * 1 (cdr args))))))
        ((eq? fn 'first) (first (car args)))
        ((eq? fn 'butfirst) (butfirst (car args)))
        ((eq? fn 'last) (last (car args)))
        ((eq? fn 'butlast) (butlast (car args)))
        ((eq? fn 'word) (foldr word "" args))
        (else (error "Calc: bad operator:" fn))))

(calc)