#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

;;; 0         => zero
;;; (s 0)     => one
;;; (s (s 0)) => two

(run-query '(assert!
             (rule (sum 0 ?x ?x)) ))
(run-query '(assert!
             (rule (sum (s ?x) ?y ?z)
                   (sum ?x (s ?y) ?z) )))

(check-equal? (run-query '(sum (s (s (s 0))) (s 0) ?result))
                         '((sum (s (s (s 0))) (s 0) (s (s (s (s 0))))) ))
