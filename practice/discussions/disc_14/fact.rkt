#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")
(require "./product.rkt")

;;; 0         => zero
;;; (s 0)     => one
;;; (s (s 0)) => two

(run-query '(assert!
             (rule (fact 0 (s 0))) ))
(run-query '(assert!
             (rule (fact (s ?x) ?y) 
                   (and (fact ?x ?i)
                        (prod ?i (s ?x) ?y)) )))

(check-equal? (run-query '(fact (s (s (s 0))) ?result))
                         '((fact (s (s (s 0))) (s (s (s (s (s (s 0)))))) )))
