#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

;;; 0         => zero
;;; (s 0)     => one
;;; (s (s 0)) => two

(run-query '(assert!
             (rule (*-1 0 0)) ))
(run-query '(assert!
             (rule (*-1 (s ?x) (?y s))
                   (*-1 ?x ?y) ) ))
(run-query '(assert!
             (rule (*-1 (?x s) (s ?y))
                   (*-1 ?x ?y) ) ))

(check-equal? (run-query '(*-1 (s (s 0)) ?what))
                         '((*-1 (s (s 0)) ((0 s) s) ) ))

(check-equal? (run-query '(*-1 ((0 s) s) ?what))
                         '((*-1 ((0 s) s) (s (s 0)) ) ))