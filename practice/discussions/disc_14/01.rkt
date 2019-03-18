#lang racket

(require rackunit)
(require "../../helpers/evaluators/qeury-eval.rkt")

(run-query '(assert! (my-list (1 2 3 4))))

(run-query '(assert!
             (rule (car (?car . ?cdr) ?car))))
(run-query '(assert!
             (rule (cdr (?car . ?cdr) ?cdr))))

(check-equal? (run-query '(and (my-list ?ls) (car ?ls ?x)))
                         '((and (my-list (1 2 3 4)) (car (1 2 3 4) 1))) )

(check-equal? (run-query '(and (my-list ?ls) (cdr ?ls ?x)))
                         '((and (my-list (1 2 3 4)) (cdr (1 2 3 4) (2 3 4)))) )