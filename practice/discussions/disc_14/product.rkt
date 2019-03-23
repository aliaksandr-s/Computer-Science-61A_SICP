#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")
(require "./sum.rkt")

;;; 0         => zero
;;; (s 0)     => one
;;; (s (s 0)) => two

(run-query '(assert!
             (rule (prod 0 ?x 0)) ))
(run-query '(assert!
             (rule (prod (s ?x) ?y ?z) 
                   (and (prod ?x ?y ?i)
                        (sum ?i ?y ?z) )) ))

(check-equal? (run-query '(prod (s (s 0)) (s (s 0)) ?result))
                         '((prod (s (s 0)) (s (s 0)) (s (s (s (s 0)))) )))
