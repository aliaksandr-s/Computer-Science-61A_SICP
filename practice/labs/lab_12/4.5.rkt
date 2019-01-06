#lang racket

(require rackunit)

(define (mc-apply procedure arguments) (list procedure arguments))

(define (mc-eval exp env)
  (cond ((if? exp) (eval-if exp env))
        ((cond? exp) (mc-eval (cond->if exp) env))
        (else exp)))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define (true? x)
  (not (eq? x false)))

(define (false? x)
  (eq? x false))

(define (cond? exp) (tagged-list? exp 'cond))

(define (cond-clauses exp) (cdr exp))

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause) (car clause))

(define (cond-actions clause) (cdr clause))

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))

(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))

(define (make-begin seq) (cons 'begin seq))

(define (expand-clauses clauses)
  (if (null? clauses)
    false
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (if (cond-else-clause? first)
        (if (null? rest)
          (sequence->exp (cond-actions first)) 
          (error "ELSE clause isn't last -- CONF->IF" clauses))
        (if (cond-consumer-clause? first)
          (make-if (cond-predicate first)
                   (list (cond-consumer first) (cond-predicate first))
                   (expand-clauses rest))
          (make-if (cond-predicate first)
                   (sequence->exp (cond-actions first))
                   (expand-clauses rest)))))))

(define (eval-if exp env)
  (if (true? (mc-eval (if-predicate exp) env))
      (mc-eval (if-consequent exp) env)
      (mc-eval (if-alternative exp) env)))

(define (if? exp) (tagged-list? exp 'if))

(define (if-predicate exp) (cadr exp))

(define (if-consequent exp) (caddr exp))

(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

(define (cond-consumer-clause? clause) (eq? (cadr clause) '=>))
(define cond-consumer caddr)

(check-equal? (cond-consumer-clause? '(#f 1)) #f)
(check-equal? (cond-consumer-clause? '((assoc ’c ’((a 1) (b 2))) => cadr)) #t)

(check-equal? (cond-consumer '((assoc ’c ’((a 1) (b 2))) => cadr)) 'cadr)

(define empty-env '())

(check-equal? (mc-eval '(cond (#f 1) (#f 4) (else 5)) empty-env) 5)
(check-equal? (mc-eval '(cond (#f 1) (#t 4) (else 5)) empty-env) 4)

(check-equal? (mc-eval '(cond (#f => #f)
                              (else 5)) 
              empty-env) 5)

(check-equal? (mc-eval '(cond ((list 1 2 3) => +)
                              (else 1)) 
              empty-env) '(+ (list 1 2 3)))
