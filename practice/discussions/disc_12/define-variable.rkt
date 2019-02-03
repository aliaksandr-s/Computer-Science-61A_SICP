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

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (mcar vars))
             (set-car! vals val))
            (else (scan (mcdr vars) (mcdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))

(define (add-binding-to-frame! var val frame)
  (set-car! frame (mcons var (mcar frame)))
  (set-cdr! frame (mcons val (mcdr frame))))

(define test-frame (make-frame (mlist 'x 'y) (mlist 3 5)))

(add-binding-to-frame! 'a 10 test-frame)

(check-equal? test-frame
              (make-frame (mlist 'a 'x 'y) (mlist 10 3 5)))

(define global-env (make-env (make-frame (mlist 'x) (mlist 3)) null))
(define first-env (make-env (make-frame (mlist 'a 'y) (mlist 1 2)) global-env))

(define-variable! 'y 12 global-env)
(define-variable! 'y 10 first-env)

(check-equal? global-env (make-env (make-frame (mlist 'y 'x) (mlist 12 3)) null))
(check-equal? first-env (make-env (make-frame (mlist 'a 'y) (mlist 1 10)) global-env))
