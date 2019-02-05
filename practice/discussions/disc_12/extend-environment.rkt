#lang racket

(require rackunit)
(require rnrs/mutable-pairs-6)
(require compatibility/mlist)

(require "../../helpers/evaluators/env-frames-helpers.rkt")

(define (extend-environment vars vals base-env)
  (if (= (mlength vars) (mlength vals))
    (make-env (make-frame vars vals) base-env)
    (if (< (mlength vars) (mlength vals))
      (error "Too many arguments supplied" vars vals)
      (error "Too few arguments supplied" vars vals))))

(define global-env (make-env (make-frame (mlist 'x) (mlist 3)) null))

(check-equal? (extend-environment (mlist 'a 'b) (mlist 5 6) global-env) 
              (make-env (make-frame (mlist 'a 'b) (mlist 5 6)) global-env))