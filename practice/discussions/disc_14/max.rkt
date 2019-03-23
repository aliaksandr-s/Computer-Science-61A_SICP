#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

;;; 0         => zero
;;; (s 0)     => one
;;; (s (s 0)) => two

(run-query '(assert!
             (rule (max ?x 0 ?x)) ))
(run-query '(assert!
             (rule (max 0 ?x ?x)) ))
(run-query '(assert!
             (rule (max (s ?x) (s ?y) (s ?z))
                   (max ?x ?y ?z) )))

(check-equal? (run-query '(max (s (s (s 0))) (s (s 0)) ?result))
                         '((max (s (s (s 0))) (s (s 0)) (s (s (s 0))) ) ))
