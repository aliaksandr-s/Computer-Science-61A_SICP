#lang racket

(require rackunit)
(require "./env-frames-helpers.rkt")

(define (lookup-variable-value var start-env)
  (cond [(and (empty? (frame-variables start-env)) 
              (empty? (enclosing-environment start-env)))
         (error "Variable not found")]
        [(empty? (frame-variables (first-frame start-env))) 
         (lookup-variable-value var (enclosing-environment start-env))]
        [(eq? (car (frame-variables (first-frame start-env))) var) 
         (car (frame-values (first-frame start-env)))]
        [else (lookup-variable-value var 
                                     (make-env (make-frame (cdr (frame-variables (first-frame start-env))) 
                                                           (cdr (frame-values (first-frame start-env)))) 
                                               (enclosing-environment start-env)))]))

(define global-env (make-env (make-frame '(x y) '(3 5)) null))
(define first-env (make-env (make-frame '(a y) '(1 2)) global-env))

(check-equal? (lookup-variable-value 'y first-env) 2)
(check-equal? (lookup-variable-value 'y global-env) 5)
(check-equal? (lookup-variable-value 'x first-env) 3)
(check-exn
   exn:fail?
   (lambda () (lookup-variable-value 'z first-env)))