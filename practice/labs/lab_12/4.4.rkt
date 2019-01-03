#lang racket

(require rackunit)

;;; helpers
(define (mc-eval exp env)
  (cond ((if? exp) (eval-if exp env))
        (else exp)))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define (if? exp) (tagged-list? exp 'if))

(define (false? x)
  (eq? x false))

(define (true? x)
  (not (eq? x false)))

(define empty-env '())

;;; a
(define (eval-and exp env)
  (cond [(empty? (cdr exp)) #t]
        [(false? (mc-eval (cadr exp) env)) #f]
        [(empty? (cddr exp)) (cadr exp)]
        [else (eval-and (cons (car exp) (cddr exp)) env)]))

(define (eval-or exp env)
  (cond [(empty? (cdr exp)) #f]
        [(true? (mc-eval (cadr exp) env)) (mc-eval (cadr exp) env)]
        [else (eval-or (cons (car exp) (cddr exp)) env)]))

(check-equal? (eval-and '(and 3 4 #f 2) empty-env) #f)
(check-equal? (eval-and '(and #f 3) empty-env) #f)
(check-equal? (eval-and '(and 1 2 3) empty-env) 3)
(check-equal? (eval-and '(and) empty-env) #t)

(check-equal? (eval-or '(or #f 3 4) empty-env) 3)
(check-equal? (eval-or '(or 2 #f) empty-env) 2)
(check-equal? (eval-or '(or #f #f) empty-env) #f)
(check-equal? (eval-or '(or) empty-env) #f)

;;; b
(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

(define (eval-if exp env)
  (if (true? (mc-eval (if-predicate exp) env))
      (mc-eval (if-consequent exp) env)
      (mc-eval (if-alternative exp) env)))

(define (and-clauses exp) (cdr exp)) 
(define (or-clauses exp) (cdr exp)) 
(define (first-exp seq) (car seq)) 
(define (rest-exp seq) (cdr seq)) 
(define (empty-exp? seq) (null? seq)) 
(define (last-exp? seq) (null? (cdr seq))) 

(define (and->if exp) 
  (expand-and-clauses (and-clauses exp))) 

(define (expand-and-clauses clauses)
  (cond ((empty-exp? clauses) (make-if #t #t #t)) 
        ((last-exp? clauses) (make-if #t (first-exp clauses) #t)) 
        (else (make-if (first-exp clauses) 
                      (expand-and-clauses (rest-exp clauses)) 
                      #f)))) 

(check-equal? (eval-if (and->if '(and)) empty-env) #t)
(check-equal? (eval-if (and->if '(and 3)) empty-env) 3)
(check-equal? (eval-if (and->if '(and 3 4 #f 2)) empty-env) #f)
(check-equal? (eval-if (and->if '(and #f 3)) empty-env) #f)
(check-equal? (eval-if (and->if '(and 1 2 3)) empty-env) 3)


(define (or->if exp) 
  (expand-or-clauses (or-clauses exp))) 

(define (expand-or-clauses clauses) 
  (cond ((empty-exp? clauses) (make-if #f #f #f)) 
        ((last-exp? clauses) (make-if #t (first-exp clauses) #t)) 
        (else (make-if (first-exp clauses) 
                      (first-exp clauses)
                      (expand-or-clauses (rest-exp clauses))))))

(check-equal? (eval-or (or->if '(or #f 3 4)) empty-env) 3)
(check-equal? (eval-or (or->if '(or 2 #f)) empty-env) 2)
(check-equal? (eval-or (or->if '(or #f #f)) empty-env) #f)
(check-equal? (eval-or (or->if '(or)) empty-env) #f)