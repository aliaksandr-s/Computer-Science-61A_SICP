#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")
(require "./product.rkt")

;;; 0         => zero
;;; (s 0)     => one
;;; (s (s 0)) => two

(run-query '(assert!
             (rule (exp ?x 0 (s 0))) ))
(run-query '(assert!
             (rule (exp ?base (s ?pow) ?z) 
                   (and (exp ?base ?pow ?i)
                        (prod ?base ?i ?z) )) ))

(check-equal? (run-query '(exp (s (s 0)) (s (s 0)) ?result))
                         '((exp (s (s 0)) (s (s 0)) (s (s (s (s 0)))) )))
