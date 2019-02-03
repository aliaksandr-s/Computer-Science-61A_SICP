#lang racket

(require rackunit)
(require rnrs/mutable-pairs-6)
(require compatibility/mlist)

(define make-frame mcons)
(define frame-variables mcar)
(define frame-values mcdr)

(define make-env mcons)
(define first-frame mcar)
(define enclosing-environment mcdr)
(define the-empty-environment '())

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (mcar vars))
             (set-car! vals val))
            (else (scan (mcdr vars) (mcdr vals)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))
  (env-loop env))

(define global-env (make-env (make-frame (mlist 'x 'y) (mlist 3 5)) null))
(define first-env (make-env (make-frame (mlist 'a 'y) (mlist 1 2)) global-env))

(set-variable-value! 'y 12 global-env)
(set-variable-value! 'y 10 first-env)

(check-equal? global-env (make-env (make-frame (mlist 'x 'y) (mlist 3 12)) null))
(check-equal? first-env (make-env (make-frame (mlist 'a 'y) (mlist 1 10)) global-env))
(check-exn
   exn:fail?
   (lambda () (set-variable-value! 'z first-env)))