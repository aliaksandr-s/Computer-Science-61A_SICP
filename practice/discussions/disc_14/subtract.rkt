#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

;;; 0         => zero
;;; (s 0)     => one
;;; (s (s 0)) => two

(run-query '(assert!
             (rule (sub ?x 0 ?x)) ))
(run-query '(assert!
             (rule (sub (s ?x) (s ?y) ?z)
                   (sub ?x ?y ?z) )))

(check-equal? (run-query '(sub (s (s (s 0))) (s (s 0)) ?result))
                         '((sub (s (s (s 0))) (s (s 0)) (s 0)) ))
