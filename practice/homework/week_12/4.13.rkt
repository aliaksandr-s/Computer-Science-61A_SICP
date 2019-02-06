#lang racket

(require rackunit)
(require rnrs/mutable-pairs-6)
(require compatibility/mlist)
; (require racket/trace)

(require "../../helpers/evaluators/env-frames-helpers.rkt")

(define (make-unbound! var env)
  (let* ((frame (first-frame env))
         (vars (frame-variables frame))
         (vals (frame-values frame)))
        (define (scan pre-vars pre-vals vars vals)
          (when (not (null? vars))
            (if (eq? var (mcar vars))
              (begin (set-mcdr! pre-vars (mcdr vars))
                     (set-mcdr! pre-vals (mcdr vals)))
              (scan vars vals (mcdr vars) (mcdr vals)))))
        ; (trace scan)
        (when (not (null? vars))
          (if (eq? var (mcar vars))
            (begin (set-mcar! frame (mcdr vars))
                   (set-mcdr! frame (mcdr vals)))
            (scan vars vals (mcdr vars) (mcdr vals))))))

(define global-env (make-env (make-frame (mlist 'x) (mlist 3)) null))
(define first-env (make-env (make-frame (mlist 'a 'y 'x 'z) (mlist 1 2 1 5)) global-env))



(make-unbound! 'x first-env)

(check-equal? first-env (make-env (make-frame (mlist 'a 'y 'z) (mlist 1 2 5)) global-env))