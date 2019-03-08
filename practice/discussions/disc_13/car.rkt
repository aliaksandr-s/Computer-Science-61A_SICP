#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

(run-query '(assert!
             (rule (car (?car . ?cdr) ?car))))

(check-equal? (run-query '(car (1 2 3 4) ?x))
                         '((car (1 2 3 4) 1)))
