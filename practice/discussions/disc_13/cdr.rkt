#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

(run-query '(assert!
             (rule (cdr (?car . ?cdr) ?cdr))))

(check-equal? (run-query '(cdr (1 2 3) ?x))
                         '((cdr (1 2 3) (2 3))))
